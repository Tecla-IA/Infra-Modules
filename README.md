# Infrastructure Modules for Tecla Academy IA

## How to use these modules

To use a module, create a `terragrunt.hcl` file that specifies the module you want to use in the `source` URL as wel as values for the input variables of that module in the `inputs` block:

```hcl
terraform {
  source = "git::git@github.com:Tecla-IA/Infra-Modules.git//path/to/module?ref=<VERSION>"
}

# Fill in the variables for that module
inputs = {
  foo = "bar"
  baz = 3
}
```

_(Note: the double slash `//` in the `source` URL is intentional and required)_

### Releasing a new version

When you're done testing the changes locally, here is how you release a new version:

1. Update the code as necessary.
1. Commit your changes to Git: `git commit -m "commit message"`.
1. Add a new Git tag using one of the following options:

   1. Using GitHub: Go to the [releases page](/releases) and click "Draft a new release".
   1. Using Git:

   ```
   git tag -a v0.0.2 -m "tag message"
   git push --follow-tags
   ```

1. Now you can use the new Git tag (e.g. `v0.0.2`) in the `ref` attribute of the `source` URL in `terragrunt.hcl`.
1. Run `terragrunt plan`.
1. If the plan looks good, run `terragrunt apply`.

## Folder structure

This repo uses the following "standard" folder structure:

- `modules`: Put module code into this folder.
- `examples`: Put example code into this folder. These are examples of how to use the modules in the `modules` folder.
  This is useful both for manual testing (you can manually run `tofu apply` on these examples) and automated testing
  (as per the tests in the `test` folder, as described next).
- `test`: Put test code into this folder. These should be automated tests for the examples in the `examples` folder.
