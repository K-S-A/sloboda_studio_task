# Test-task solution for ([Sloboda Studio](http://sloboda-studio.com))
---
## Structure
- Source code (`lib/`):
  - `braces_task.rb` (code for first task);
  - `cities_task.rb` (code for second task);
  - `factorial_task.rb` (code for third task).
- Unit tests (`spec/`):
  - `lib/braces_task/braces_spec.rb` (specs for first task code);
  - `lib/cities_task/cities_spec.rb` (specs for second task code);
  - `lib/factorial_task/` (specs for second task code);
  - `lib/support/` (`*.json` and `*.txt` files with sample test data);
  - `spec_helper.rb` (configuration of RSpec suite);
  - `shared_stuff.rb` (shared examples and contexts for specs);
  - `helpers.rb` (contain `Helpers` and `Helpers::ClassMethods` modules that included in Rspec configuration).
- Benchmark (`benchmark/`), holds productivity tests for factorial_task.

### Run specs
Run bundle to install dependencies:
```bash
$ bundle
```
Run all specs with:
```bash
$ rspec
```
To run specific group of specs:
```bash
$ rspec --tag braces_task
# or
$ rspec --tag cities_task
# or
$ rspec --tag factorial_task
```
