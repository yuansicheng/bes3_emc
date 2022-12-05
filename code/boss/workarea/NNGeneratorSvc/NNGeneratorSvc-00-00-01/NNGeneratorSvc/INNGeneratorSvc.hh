#ifndef INNGENERATORSVC_H_
#define INNGENERATORSVC_H_

#include "GaudiKernel/IInterface.h"
#include "GaudiKernel/Kernel.h"
#include <vector>
#include <string>

#include "G4ThreeVector.hh"

class EmcHit;

/* Declaration of the interface ID */
static const InterfaceID IID_INNGeneratorSvc("INNGeneratorSvc",1,0);

class INNGeneratorSvc: virtual public IInterface{
    public:
        static const InterfaceID& interfaceID() { return IID_INNGeneratorSvc; }
        virtual bool getUseNN()=0;
        virtual void generate(G4ThreeVector mom, G4ThreeVector emc_pos)=0;
        virtual std::vector<EmcHit>* getHitCol()=0;
        virtual std::string getTargetParticle()=0;

};

#endif
