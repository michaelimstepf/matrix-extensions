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

Element-wise multiplication:

```ruby
require 'matrix_extensions' # if not loaded automatically

MatrixExtended[ [1,2,3], [4,5,6] ].element_multiplication MatrixExtended[ [2,3,4], [5,6,7] ]
=> MatrixExtended[[2, 6, 12], [20, 30, 42]]
```

Element-wise division:

```ruby
require 'matrix_extensions' # if not loaded automatically

MatrixExtended[ [2,4,6], [2.0,10,20] ].element_division MatrixExtended[ [2,2,6], [4,5,10] ]
=> MatrixExtended[[1, 2, 1], [0.5, 2, 2]]
```

Element-wise exponentiation:

```ruby
require 'matrix_extensions' # if not loaded automatically

MatrixExtended[ [2,4], [1,4] ].element_exponentiation MatrixExtended[ [2,4], [1,4]] ]
=> MatrixExtended[[4, 256], [1, 256]]
```

Prefilled matrix with zeros or ones:

```ruby
require 'matrix_extensions' # if not loaded automatically

MatrixExtended.zeros(2,4)
=> MatrixExtended[[0, 0, 0, 0], [0, 0, 0, 0]]

MatrixExtended.ones(2,2)
=> MatrixExtended[[1, 1], [1, 1]]
```

Concatenating matrices and vectors horizontally:

This iterates through a list of matrices and vectors and appends columns of each list one after another. The row number of all matrices and vectors must be equal. The number of arguments passed in can be freely chosen.

```ruby
require 'matrix_extensions' # if not loaded automatically

m1 = Matrix[ [1,2,3], [4,5,6] ]
m2 = Matrix[ [2,3,4], [5,6,7] ]
v = Vector[ 3,4 ]

MatrixExtended.hconcat(m1, m2, v)
=> MatrixExtended[[1, 2, 3, 2, 3, 4, 3], [4, 5, 6, 5, 6, 7, 4]]
```

Concatenating matrices and vectors vertically:

This iterates through a list of matrices and vectors and appends rows of each list one after another. The column number of all matrices and vectors must be equal. The number of arguments passed in can be freely chosen.

```ruby
require 'matrix_extensions' # if not loaded automatically

m1 = Matrix[ [1,2,3], [4,5,6] ]
m2 = Matrix[ [2,3,4], [5,6,7] ]
v = Vector[ 3,4,5 ]

MatrixExtended.vconcat(m1, m2, v)
=> MatrixExtended[[1, 2, 3], [4, 5, 6], [2, 3, 4], [5, 6, 7], [3, 4, 5]]
```

Converting a `Matrix` object to a `MatrixExtended` object:

```ruby
require 'matrix_extensions' # if not loaded automatically

MatrixExtended.convert_to_matrix_extended Matrix[ [1,2,3], [4,5,6] ]
=> MatrixExtended[[1, 2, 3], [4, 5, 6]]
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/matrix_extensions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
