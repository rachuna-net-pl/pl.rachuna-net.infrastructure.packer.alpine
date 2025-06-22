```
podman run -it -v $PWD:/packer -u root registry.gitlab.com/pl.rachuna-net/containers/packer:1.0.1 bash
```

```hcl
packer build -var-file=pkrvars/variables.pkrvars.hcl  .
```