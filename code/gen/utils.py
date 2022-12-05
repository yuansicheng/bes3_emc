def replaceJobOptionValue(content, replace_dict):
    for k, v in replace_dict.items():
        if isinstance(v, str) and v not in ('true', 'false'):
            v = '\"{}\"'.format(v)
        for i, line in enumerate(content):
            if line.startswith(k):
                content[i] = '{} = {}; \n'.format(k, v)
    return content