# Extension of the Ruby Matrix class

This gem extends the [Ruby Matrix class](http://www.ruby-doc.org/stdlib-2.1.2/libdoc/matrix/rdoc/Matrix.html) by providing additional methods.

It is more light-weight and less powerful than the [SciRuby NMatrix module](https://github.com/SciRuby/nmatrix). It is also easier to install than the NMatrix module since there is no need to manually install libraries and configure the operating system.

## Installation

Add this line to your application's Gemfile:

    gem 'matrix_extensions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matrix_extensions

## Usage

*Element-wise multiplication:*

```ruby
require 'matrix_extensions'

Matrix[ [1,2,3], [4,5,6] ].element_multiplication Matrix[ [2,3,4], [5,6,7] ]
=> Matrix[[2, 6, 12], [20, 30, 42]]
```

*Element-wise division:*

```ruby
require 'matrix_extensions'

Matrix[ [2,4,6], [2.0,10,20] ].element_division Matrix[ [2,2,6], [4,5,10] ]
=> Matrix[[1, 2, 1], [0.5, 2, 2]]
```

*Element-wise exponentiation:*

```ruby
require 'matrix_extensions'

Matrix[ [2,4], [1,4] ].element_exponentiation Matrix[ [2,4], [1,4]] ]
=> Matrix[[4, 256], [1, 256]]
```

*Prefilled matrix with zeros or ones:*

```ruby
require 'matrix_extensions'

Matrix.zeros(2,4)
=> Matrix[[0, 0, 0, 0], [0, 0, 0, 0]]

Matrix.ones(2,2)
=> Matrix[[1, 1], [1, 1]]
```

*Concatenating matrices and vectors horizontally:*

This iterates through a list of matrices and vectors and appends columns of each list one after another. The row number of all matrices and vectors must be equal. The number of arguments passed in can be freely chosen.

```ruby
require 'matrix_extensions'

m1 = Matrix[ [1,2,3], [4,5,6] ]
m2 = Matrix[ [2,3,4], [5,6,7] ]
v = Vector[ 3,4 ]

Matrix.hconcat(m1, m2, v)
=> Matrix[[1, 2, 3, 2, 3, 4, 3], [4, 5, 6, 5, 6, 7, 4]]
```

*Concatenating matrices and vectors vertically:*

This iterates through a list of matrices and vectors and appends rows of each list one after another. The column number of all matrices and vectors must be equal. The number of arguments passed in can be freely chosen.

```ruby
require 'matrix_extensions'

m1 = Matrix[ [1,2,3], [4,5,6] ]
m2 = Matrix[ [2,3,4], [5,6,7] ]
v = Vector[ 3,4,5 ]

Matrix.vconcat(m1, m2, v)
=> Matrix[[1, 2, 3], [4, 5, 6], [2, 3, 4], [5, 6, 7], [3, 4, 5]]
```

*Removing trailing columns:*

Removes a set number of trailing columns from a matrix. The argument defaults to 1.

```ruby
require 'matrix_extensions'

Matrix[ [1,2,3], [4,5,6] ].hpop(2)
=> Matrix[[1], [4]]
```

*Removing trailing rows:*

Removes a set number of trailing rows from a matrix. The argument defaults to 1.

```ruby
require 'matrix_extensions'

Matrix[ [1,2,3], [4,5,6], [7,8,9] ].vpop(2)
=> Matrix[[1, 2, 3]]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/matrix_extensions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
