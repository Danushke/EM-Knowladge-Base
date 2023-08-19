# Private Pods

Cocoapods supports creating and using private pods alongside with public pods. Private pods usually stored at private repository in a source code management system such as GitHub, Bitbucket etc.

Each Cocoapod has 2 counterparts:
  - [Pod Spec Repository](https://guides.cocoapods.org/making/specs-and-specs-repo.html)
  - [Pod Repository](https://guides.cocoapods.org/making/making-a-cocoapod.html)

## Creating Private Pods

Add `iBaseSpecs` Pod Spec Repository to your local pods

```
$ pod repo add iBaseSpecs https://BITBUCKET-USERNAME@bitbucket.org/elegantmedia/ibasespecs.git
```
