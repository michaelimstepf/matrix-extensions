require "matrix_extensions/version"
require 'matrix'

# An extension to the Ruby Matrix class.
# @author Michael Imstepf
class MatrixExtended < Matrix
  # Converts a Matrix to an MatrixExtended.
  # @param m [Matrix] matrix
  # @return [MatrixExtended] matrix
  # @raise [TypeError] if matrices are not of type Matrix
  def self.convert_to_matrix_extended(m)
    raise TypeError, "#{m.class} is not a Matrix" unless m.is_a?(Matrix)

    self.columns(m.column_vectors)
  end

  # Matrix prefilled with zeros.
  # @param m [MatrixExtended] matrix
  # @return [MatrixExtended] matrix
  def self.zeros(rows = 1, columns = 1)
    MatrixExtended.build(rows, columns) { 0 }
  end
  self.singleton_class.send(:alias_method, :zeroes, :zeros)

  # Matrix prefilled with ones.
  # @param m [MatrixExtended] matrix
  # @return [MatrixExtended] matrix  
  def self.ones(rows = 1, columns = 1)
    MatrixExtended.build(rows, columns) { 1 }
  end

  # Concatenates two matrices horizontally (resulting in more columns).
  # @param *matrices [MatrixExtended] matrices
  # @return [MatrixExtended] concatenated matrix
  # @raise [ErrDimensionMismatch] if dimensions don't match
  # @raise [TypeError] if matrices are not of type Matrix or Vector 
  def self.hconcat(*matrices)        
    columns = []
    matrices.each do |m|
      raise TypeError, "#{m.class} is not a Matrix or Vector" unless m.is_a?(Matrix) || m.is_a?(Vector)
      
      # convert Vector to Matrix
      m = self.convert_vector_to_matrix(m, :column) if m.is_a? Vector

      # check if dimensions match
      row_count ||= m.row_count
      Matrix.Raise ErrDimensionMismatch unless row_count == m.row_count
      
      # prepare array of columns
      m.column_vectors.each do |v|
        columns << v.to_a
      end
    end

    # create new matrix
    self.columns(columns)
  end  

  # Concatenates two matrices vertically (resulting in more rows).
  # @param *matrices [MatrixExtended] matrices
  # @return [MatrixExtended] concatenated matrix
  # @raise [ErrDimensionMismatch] if dimensions don't match
  # @raise [TypeError] if matrices are not of type Matrix or Vector  
  def self.vconcat(*matrices)
    rows = []
    matrices.each do |m|
      raise TypeError, "#{m.class} is not a Matrix or Vector" unless m.is_a?(Matrix) || m.is_a?(Vector)
      
      # convert Vector to Matrix
      m = self.convert_vector_to_matrix(m, :row) if m.is_a? Vector

      # check if dimensions match
      column_count ||= m.column_count
      Matrix.Raise ErrDimensionMismatch unless column_count == m.column_count
      
      # prepare array of columns
      m.row_vectors.each do |v|
        rows << v.to_a
      end
    end

    # create new matrix
    self.rows(rows)
  end  

  # Element-wise division.
  # @param m [MatrixExtended] matrix
  # @return [MatrixExtended] matrix
  # @raise [ErrDimensionMismatch] if dimensions don't match
  def element_division(m)
    case m
    when Numeric
      return self./ m
    when Vector            
      if row_count > column_count
        # Matrix is of dimension X * 1 (or there'll be an ErrDimensionMismatch)
        m = self.class.convert_vector_to_matrix(m, :column)      
      else
        # Matrix is of dimension 1 * X (or there'll be an ErrDimensionMismatch)
        m = self.class.convert_vector_to_matrix(m, :row)
      end
    when Matrix
    else
      return apply_through_coercion(m, __method__)
    end

    Matrix.Raise ErrDimensionMismatch unless row_count == m.row_count && column_count == m.column_count

    rows = Array.new(row_count) do |i|
      Array.new(column_count) do|j|
        self[i, j] / m[i, j]
      end
    end
    new_matrix rows, column_count  
  end
  
  # Element-wise multiplication.
  # @param m [MatrixExtended] matrix
  # @return [MatrixExtended] matrix
  # @raise [ErrDimensionMismatch] if dimensions don't match  
  def element_multiplication(m)
    case m
    when Numeric
      return self.* m
    when Vector            
      if row_count > column_count
        # Matrix is of dimension X * 1 (or there'll be an ErrDimensionMismatch)
        m = self.class.convert_vector_to_matrix(m, :column)      
      else
        # Matrix is of dimension 1 * X (or there'll be an ErrDimensionMismatch)
        m = self.class.convert_vector_to_matrix(m, :row)
      end
    when Matrix
    else
      return apply_through_coercion(m, __method__)
    end

    Matrix.Raise ErrDimensionMismatch unless row_count == m.row_count && column_count == m.column_count

    rows = Array.new(row_count) do |i|
      Array.new(column_count) do|j|
        self[i, j] * m[i, j]
      end
    end
    new_matrix rows, column_count  
  end

  # Element-wise exponentiation.
  # @param m [MatrixExtended] matrix
  # @return [MatrixExtended] matrix
  # @raise [ErrDimensionMismatch] if dimensions don't match  
  def element_exponentiation(m)
    case m
    when Numeric
      # self.** m will break
      rows = @rows.collect {|row|
        row.collect {|e| e ** m }
      }
      return new_matrix rows, column_count
    when Vector            
      if row_count > column_count
        # Matrix is of dimension X * 1 (or there'll be an ErrDimensionMismatch)
        m = self.class.convert_vector_to_matrix(m, :column)      
      else
        # Matrix is of dimension 1 * X (or there'll be an ErrDimensionMismatch)
        m = self.class.convert_vector_to_matrix(m, :row)
      end
    when Matrix
    else
      return apply_through_coercion(m, __method__)
    end

    Matrix.Raise ErrDimensionMismatch unless row_count == m.row_count && column_count == m.column_count

    rows = Array.new(row_count) do |i|
      Array.new(column_count) do|j|
        self[i, j] ** m[i, j]
      end
    end
    new_matrix rows, column_count 
  end

  private

  # Convert vector to matrix for arithmetic operations.
  # @param vector [Vector] vector
  # @param dimension [Symbol] :row or :column
  # @return [MatrixExtended] matrix
  # @raise [TypeError] if vector ist not of type Vector    
  def self.convert_vector_to_matrix(v, dimension)
    raise TypeError, "#{v.class} is not a Vector" unless v.is_a? Vector    

    if dimension == :row
      self.row_vector(v)
    elsif dimension == :column
      self.column_vector(v)
    else
      raise ArgumentError
    end
  end
end