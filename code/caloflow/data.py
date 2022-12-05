""" Dataloader for calorimeter data.
    Inspired by https://github.com/kamenbliznashki/normalizing_flows

    Used for
    "CaloFlow: Fast and Accurate Generation of Calorimeter Showers with Normalizing Flows"
    by Claudius Krause and David Shih
    arxiv:2106.05285

"""

import os
import h5py
import numpy as np
import torch
# import torchvision.transforms as T
from torch.utils.data import Dataset, DataLoader

from tqdm import tqdm

import sys

ALPHA = 1e-6
def logit(x):
    return np.log(x / (1.0 - x))

def logit_trafo(x):
    local_x = ALPHA + (1. - 2.*ALPHA) * x
    return logit(local_x)


class CaloDataset_v2(Dataset):
    """CaloGAN dataset of [2]."""

    def __init__(self, path_to_file, particle_type,
                 transform_0=None, transform_1=None, transform_2=None,
                 apply_logit=True, prefix=None, with_noise=False,
                 return_label=False, region=5, ):
        """
        Args:
            path_to_file (string): path to folder of .hdf5 files
            particle_type (string): name of particle: gamma, eplus, or piplus
            transform_i (callable, optional): Optional transform to be applied
            on data of layer i
        """
        input_list = [os.path.join(path_to_file,f) for f in os.listdir(path_to_file) if f.endswith('.h5')]

        # if prefix:
        #     #self.path_to_file = os.path.join(path_to_file, prefix+particle_type+'.hdf5')
        #     #self.path_to_file = os.path.join(path_to_file, prefix+particle_type+'.h5')
        #     for i in files:
        #         if prefix in i:
        #             input_list.append('%s/%s'%(path_to_file,i))
        # else:
        #     #self.path_to_file = os.path.join(path_to_file, particle_type+'.hdf5')
        #     #self.path_to_file = os.path.join(path_to_file, particle_type+'.h5')
        #     for i in files:
        #         input_list.append('%s/%s'%(path_to_file,i))


        self.apply_logit = apply_logit
        self.with_noise = with_noise

        self.transform_0 = transform_0
        self.transform_1 = transform_1
        self.transform_2 = transform_2

        self.return_label = return_label

        self.input_dims = {'0': (region, region)}
        self.input_size = {'0': region**2}

        self.file_layer_0 = None
        self.file_label = None
        isFirst = True
        for i in tqdm(input_list):
            full_file = h5py.File(i, 'r')
            shower    = np.float64( full_file['hit_img'][:,:,:])
            label_mom = np.float64( full_file['momentum'][:] )
            label_mom = np.expand_dims(label_mom, axis=-1)
            label_dtheta = np.float64( full_file['theta'][:] )
            label_dtheta = np.expand_dims(label_dtheta, axis=-1)
            label_dphi = np.float64( full_file['phi'][:] )
            label_dphi = np.expand_dims(label_dphi, axis=-1)
            labels      = np.float64( np.concatenate((label_mom, label_dtheta, label_dphi), axis=1)  )
            if isFirst:
                self.file_layer_0 = shower
                self.file_label = labels
                isFirst = False
            else:
                self.file_layer_0 = np.float64( np.concatenate((self.file_layer_0, shower), axis=0)  )
                self.file_label   = np.float64( np.concatenate((self.file_label  , labels), axis=0)  )
            full_file.close()
        print('input data size=',self.file_layer_0.shape)

    def __len__(self):
        # assuming file was written correctly
        return len(self.file_layer_0)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()
        layer_0 = self.file_layer_0[idx]
        layer_0_ori = self.file_layer_0[idx]

        if self.with_noise:
            layer_0 = add_noise(layer_0)

        layer_0_E = layer_0.sum(axis=(-1, -2), keepdims=True) #(1,1)
        layer_0_E = layer_0_E[:,0]
        if self.transform_0:
            if self.transform_0 == 'L_norm':
                layer_0 = layer_0 / (layer_0_E + 1e-16)

        if self.apply_logit:
            layer_0 = logit_trafo(layer_0)

        sample = {'layer_0': layer_0, 'layer_0_E': layer_0_E, 'layer_0_ori':layer_0_ori}
        if self.return_label:
            sample['label'] = self.file_label[idx]

        # print(sample)
        # sys.exit(1)

        return sample


class CaloDataset_v1(Dataset):
    """CaloGAN dataset of [2]."""

    def __init__(self, path_to_file, particle_type,
                 transform_0=None, transform_1=None, transform_2=None,
                 apply_logit=True, prefix=None, with_noise=False,
                 return_label=False):
        """
        Args:
            path_to_file (string): path to folder of .hdf5 files
            particle_type (string): name of particle: gamma, eplus, or piplus
            transform_i (callable, optional): Optional transform to be applied
            on data of layer i
        """
        files = os.listdir(path_to_file)
        input_list = []

        if prefix:
            #self.path_to_file = os.path.join(path_to_file, prefix+particle_type+'.hdf5')
            #self.path_to_file = os.path.join(path_to_file, prefix+particle_type+'.h5')
            for i in files:
                if prefix in i:
                    input_list.append('%s/%s'%(path_to_file,i))
        else:
            #self.path_to_file = os.path.join(path_to_file, particle_type+'.hdf5')
            #self.path_to_file = os.path.join(path_to_file, particle_type+'.h5')
            for i in files:
                input_list.append('%s/%s'%(path_to_file,i))


        self.apply_logit = apply_logit
        self.with_noise = with_noise

        self.transform_0 = transform_0
        self.transform_1 = transform_1
        self.transform_2 = transform_2

        self.return_label = return_label

        #self.input_dims = {'0': (3, 96), '1': (12, 12), '2': (12, 6)}
        #self.input_size = {'0': 288, '1': 144, '2': 72}
        self.input_dims = {'0': (5, 5)}
        self.input_size = {'0': 25    }

        self.file_layer_0 = None
        self.file_label = None
        isFirst = True
        for i in input_list:
            full_file = h5py.File(i, 'r')
            shower    = np.float64( full_file['leading_shower_5x5'][:,:,:]) ##N * 5*5
            label_mom = np.float64( full_file['momentum'][:] )
            label_mom = np.expand_dims(label_mom, axis=-1)
            label_theta = np.float64( full_file['theta'][:] )
            label_theta = np.expand_dims(label_theta, axis=-1)
            labels      = np.float64( np.concatenate((label_mom, label_theta), axis=1)  )
            if isFirst:
                self.file_layer_0 = shower
                self.file_label = labels
                isFirst = False
            else:
                self.file_layer_0 = np.float64( np.concatenate((self.file_layer_0, shower), axis=0)  )
                self.file_label   = np.float64( np.concatenate((self.file_label  , labels), axis=0)  )
            full_file.close()
        print('input data size=',self.file_layer_0.shape)

    def __len__(self):
        # assuming file was written correctly
        return len(self.file_layer_0)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()
        layer_0 = self.file_layer_0[idx]
        layer_0_ori = self.file_layer_0[idx]

        if self.with_noise:
            layer_0 = add_noise(layer_0)

        layer_0_E = layer_0.sum(axis=(-1, -2), keepdims=True) #(1,1)
        layer_0_E = layer_0_E[:,0]
        if self.transform_0:
            if self.transform_0 == 'L_norm':
                layer_0 = layer_0 / (layer_0_E + 1e-16)

        if self.apply_logit:
            layer_0 = logit_trafo(layer_0)

        sample = {'layer_0': layer_0, 'layer_0_E': layer_0_E, 'layer_0_ori':layer_0_ori}
        if self.return_label:
            sample['label'] = self.file_label[idx]

        return sample

class CaloDataset(Dataset):
    """CaloGAN dataset of [2]."""

    def __init__(self, path_to_file, particle_type,
                 transform_0=None, transform_1=None, transform_2=None,
                 apply_logit=True, prefix=None, with_noise=False,
                 return_label=False):
        """
        Args:
            path_to_file (string): path to folder of .hdf5 files
            particle_type (string): name of particle: gamma, eplus, or piplus
            transform_i (callable, optional): Optional transform to be applied
            on data of layer i
        """

        if prefix:
            #self.path_to_file = os.path.join(path_to_file, prefix+particle_type+'.hdf5')
            self.path_to_file = os.path.join(path_to_file, prefix+particle_type+'.h5')
        else:
            #self.path_to_file = os.path.join(path_to_file, particle_type+'.hdf5')
            self.path_to_file = os.path.join(path_to_file, particle_type+'.h5')

        self.full_file = h5py.File(self.path_to_file, 'r')

        self.apply_logit = apply_logit
        self.with_noise = with_noise

        self.transform_0 = transform_0
        self.transform_1 = transform_1
        self.transform_2 = transform_2

        self.return_label = return_label

        #self.input_dims = {'0': (3, 96), '1': (12, 12), '2': (12, 6)}
        #self.input_size = {'0': 288, '1': 144, '2': 72}
        self.input_dims = {'0': (11, 11)}
        self.input_size = {'0': 121     }

        # normalizations to 100 GeV
        self.file_layer_0 = np.float64( self.full_file['Barrel_Hit'][:,:,:,0]) ##N * 11 * 11 * 1
        #self.file_layer_0 = self.full_file['layer_0'][:] / 1e5
        #self.file_layer_1 = self.full_file['layer_1'][:] / 1e5
        #self.file_layer_2 = self.full_file['layer_2'][:] / 1e5
        self.file_label = np.float64( self.full_file['MC_info'][:] )
        self.full_file.close()

    def __len__(self):
        # assuming file was written correctly
        return len(self.file_layer_0)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()
        layer_0 = self.file_layer_0[idx]
        layer_0_ori = self.file_layer_0[idx]
        #layer_1 = self.file_layer_1[idx]
        #layer_2 = self.file_layer_2[idx]
        #energy = self.file_energy[idx]
        energy = self.file_label[idx,0]##mom

        if self.with_noise:
            layer_0 = add_noise(layer_0)
            #layer_1 = add_noise(layer_1)
            #layer_2 = add_noise(layer_2)

        layer_0_E = layer_0.sum(axis=(-1, -2), keepdims=True) #(1,1)
        #print('layer_0_E shape=',layer_0_E.shape)
        #layer_1_E = layer_1.sum(axis=(-1, -2), keepdims=True)
        #layer_2_E = layer_2.sum(axis=(-1, -2), keepdims=True)
        #layer_0_E = layer_0_E.squeeze()##(N,)
        overflow = energy - layer_0_E[0,0]
        #print('before layer_0_E shape=',layer_0_E.shape)
        #layer_0_E = np.expand_dims(layer_0_E, axis=1) #from (N,) to (N,1)
        layer_0_E = layer_0_E[:,0]
        #print('after layer_0_E shape=',layer_0_E.shape)
        if self.transform_0:
            if self.transform_0 == 'E_norm':
                layer_0 = layer_0 / energy
            elif self.transform_0 == 'L_norm':
                layer_0 = layer_0 / (layer_0_E + 1e-16)
            #else:
            #    layer_0 = self.transform_0(layer_0)

        #if self.transform_1:
        #    if self.transform_1 == 'E_norm':
        #        layer_1 = layer_1 / energy
        #    elif self.transform_1 == 'L_norm':
        #        layer_1 = layer_1 / (layer_1_E + 1e-16)
        #    else:
        #        layer_1 = self.transform_1(layer_1)

        #if self.transform_2:
        #    if self.transform_2 == 'E_norm':
        #        layer_2 = layer_2 / energy
        #    elif self.transform_2 == 'L_norm':
        #        layer_2 = layer_2 / (layer_2_E + 1e-16)
        #    else:
        #        layer_2 = self.transform_2(layer_2)

        if self.apply_logit:
            layer_0 = logit_trafo(layer_0)
            #layer_1 = logit_trafo(layer_1)
            #layer_2 = logit_trafo(layer_2)

        #sample = {'layer_0': layer_0, 'layer_1': layer_1,'layer_2': layer_2, 'energy': energy,'overflow': overflow, 'layer_0_E': layer_0_E.squeeze(), 'layer_1_E': layer_1_E.squeeze(), 'layer_2_E': layer_2_E.squeeze()}
        sample = {'layer_0': layer_0, 'energy': energy,'overflow': overflow, 'layer_0_E': layer_0_E, 'layer_0_ori':layer_0_ori}
        if self.return_label:
            #sample['label'] = self.full_file['label'][idx]
            sample['label'] = self.file_label[idx]

        return sample

def get_dataloader(particle_type, data_dir, device, full,
                   batch_size=32, apply_logit=True, with_noise=False, normed=False,
                   normed_layer=False, return_label=True):

    if normed and normed_layer:
        raise ValueError("Cannot normalize data to layer and event simultaenously")

    kwargs = {'num_workers': 2, 'pin_memory': True} if device.type is 'cuda' else {}

    if normed:
        dataset_kwargs = {'transform_0': 'E_norm',
                          'transform_1': 'E_norm',
                          'transform_2': 'E_norm',
                          'with_noise': with_noise}
    elif normed_layer:
        dataset_kwargs = {'transform_0': 'L_norm',
                          'transform_1': 'L_norm',
                          'transform_2': 'L_norm',
                          'with_noise': with_noise}
    else:
        dataset_kwargs = {'with_noise': with_noise}

    if full:
        dataset = CaloDataset(data_dir, particle_type, apply_logit=apply_logit,
                              return_label=return_label)
        return DataLoader(dataset, batch_size=batch_size,
                          shuffle=False, **kwargs)
    else:
        train_dataset = CaloDataset(data_dir, particle_type, apply_logit=apply_logit,
                                    prefix='train_', return_label=return_label, **dataset_kwargs)
        test_dataset = CaloDataset(data_dir, particle_type, apply_logit=apply_logit,
                                   prefix='test_', return_label=return_label, **dataset_kwargs)

        train_dataloader = DataLoader(train_dataset, batch_size=batch_size,
                                      shuffle=True, **kwargs)
        test_dataloader = DataLoader(test_dataset, batch_size=batch_size,
                                     shuffle=False, **kwargs)
        return train_dataloader, test_dataloader


def get_dataloader_v1(particle_type, data_dir, device, full,
                   batch_size=32, apply_logit=True, with_noise=False, normed=False,
                   normed_layer=False, return_label=True):

    if normed and normed_layer:
        raise ValueError("Cannot normalize data to layer and event simultaenously")

    kwargs = {'num_workers': 2, 'pin_memory': True} if device.type is 'cuda' else {}

    if normed:
        dataset_kwargs = {'transform_0': 'E_norm',
                          'transform_1': 'E_norm',
                          'transform_2': 'E_norm',
                          'with_noise': with_noise}
    elif normed_layer:
        dataset_kwargs = {'transform_0': 'L_norm',
                          'transform_1': 'L_norm',
                          'transform_2': 'L_norm',
                          'with_noise': with_noise}
    else:
        dataset_kwargs = {'with_noise': with_noise}

    if full:
        dataset = CaloDataset_v1(data_dir, particle_type, apply_logit=apply_logit,
                              return_label=return_label)
        return DataLoader(dataset, batch_size=batch_size,
                          shuffle=False, **kwargs)
    else:
        train_dataset = CaloDataset_v1(data_dir, particle_type, apply_logit=apply_logit,
                                    prefix='train_', return_label=return_label, **dataset_kwargs)
        test_dataset = CaloDataset_v1(data_dir, particle_type, apply_logit=apply_logit,
                                   prefix='test_', return_label=return_label, **dataset_kwargs)

        train_dataloader = DataLoader(train_dataset, batch_size=batch_size,
                                      shuffle=True, **kwargs)
        test_dataloader = DataLoader(test_dataset, batch_size=batch_size,
                                     shuffle=False, **kwargs)
        return train_dataloader, test_dataloader

def get_dataloader_v2(particle_type, data_dir, device, full,
                   batch_size=32, apply_logit=True, with_noise=False, normed=False,
                   normed_layer=False, return_label=True, region=5):

    if normed and normed_layer:
        raise ValueError("Cannot normalize data to layer and event simultaenously")

    kwargs = {'num_workers': 2, 'pin_memory': True} if device.type is 'cuda' else {}

    if normed:
        dataset_kwargs = {'transform_0': 'E_norm',
                          'transform_1': 'E_norm',
                          'transform_2': 'E_norm',
                          'with_noise': with_noise}
    elif normed_layer:
        dataset_kwargs = {'transform_0': 'L_norm',
                          'transform_1': 'L_norm',
                          'transform_2': 'L_norm',
                          'with_noise': with_noise}
    else:
        dataset_kwargs = {'with_noise': with_noise}

    if full:
        dataset = CaloDataset_v2(data_dir, particle_type, apply_logit=apply_logit,
                              return_label=return_label)
        return DataLoader(dataset, batch_size=batch_size,
                          shuffle=False, **kwargs)
    else:
        train_dataset = CaloDataset_v2(data_dir, particle_type, apply_logit=apply_logit,
                                    prefix='train_', return_label=return_label, region=region,  **dataset_kwargs)
        test_dataset = CaloDataset_v2(data_dir, particle_type, apply_logit=apply_logit,
                                   prefix='test_', return_label=return_label, region=region,  **dataset_kwargs)

        train_dataloader = DataLoader(train_dataset, batch_size=batch_size,
                                      shuffle=True, **kwargs)
        test_dataloader = DataLoader(test_dataset, batch_size=batch_size,
                                     shuffle=False, **kwargs)
        return train_dataloader, test_dataloader

def add_noise(input_tensor):
    noise = np.random.rand(*input_tensor.shape)*1e-8
    return input_tensor+noise

def save_samples_to_file(samples, energies, filename, threshold):
    """ saves the given sample to hdf5 file, like training data
        add 0s to overflow to match structure of training data
    """

    assert len(energies) == len(samples)

    data = samples.clamp_(0., 1e5).to('cpu').numpy()
    data = np.where(data < threshold, np.zeros_like(data), data)

    energies = energies.to('cpu').unsqueeze(-1).numpy()*1e2
    overflow = np.zeros((len(energies), 3))
    layer_0 = data[..., :288].reshape(-1, 3, 96)
    layer_1 = data[..., 288:432].reshape(-1, 12, 12)
    layer_2 = data[..., 432:].reshape(-1, 12, 6)

    save_file = h5py.File(filename, 'w')

    save_file.create_dataset('layer_0', data=layer_0)
    save_file.create_dataset('layer_1', data=layer_1)
    save_file.create_dataset('layer_2', data=layer_2)
    save_file.create_dataset('energy', data=energies)
    save_file.create_dataset('overflow', data=overflow)

    save_file.close()


def save_samples_to_file_v1(samples, rec_E, real_img, real_E, real_label, filename, threshold, shape_x=11, shape_y=11):
    """ saves the given sample to hdf5 file, like training data
        add 0s to overflow to match structure of training data
    """

    assert len(real_img) == len(samples)
    samples = samples .to('cpu').numpy()
    rec_E   = rec_E   .to('cpu').numpy()
    real_img= real_img.to('cpu').numpy()
    real_E  = real_E  .to('cpu').numpy()
    real_label= real_label.to('cpu').numpy()

    #samples = samples.reshape(-1, 11, 11)
    samples = samples.reshape(-1, shape_x, shape_y)
    #data = samples.clamp_(0., 1e5).to('cpu').numpy()
    #data = np.where(data < threshold, np.zeros_like(data), data)
    #energies = energies.to('cpu').unsqueeze(-1).numpy()*1e2
    #overflow = np.zeros((len(energies), 3))
    #layer_0 = data[..., :288].reshape(-1, 3, 96)
    #layer_1 = data[..., 288:432].reshape(-1, 12, 12)
    #layer_2 = data[..., 432:].reshape(-1, 12, 6)

    save_file = h5py.File(filename, 'w')
    save_file.create_dataset('real_shower', data=real_img)
    save_file.create_dataset('real_E'     , data=real_E  )
    save_file.create_dataset('real_label' , data=real_label)
    save_file.create_dataset('gen_shower' , data=samples)
    save_file.create_dataset('gen_E'      , data=rec_E)
    save_file.close()

def save_samples_to_file_v2(samples, rec_E, real_img, real_E, real_label, filename, threshold, shape_x=11, shape_y=11):
    """ saves the given sample to hdf5 file, like training data
        add 0s to overflow to match structure of training data
    """

    assert len(real_img) == len(samples)
    samples = samples .to('cpu').numpy()
    rec_E   = rec_E   .to('cpu').numpy()
    real_img= real_img.to('cpu').numpy()
    real_E  = real_E  .to('cpu').numpy()
    real_label= real_label.to('cpu').numpy()

    samples = samples.reshape(-1, shape_x, shape_y)

    save_file = h5py.File(filename, 'w')
    save_file.create_dataset('real_shower', data=real_img)
    save_file.create_dataset('real_E'     , data=real_E  )
    save_file.create_dataset('real_label' , data=real_label)
    save_file.create_dataset('gen_shower' , data=samples)
    save_file.create_dataset('gen_E'      , data=rec_E)
    save_file.close()
