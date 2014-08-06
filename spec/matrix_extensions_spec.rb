require 'spec_helper'

describe Matrix do
  m23a = Matrix[ [1,2,3], [4,5,6] ] # 2 rows, 3 columns
  m23b = Matrix[ [2,3,4], [5,6,7] ] # 2 rows, 3 columns
  m22 = Matrix[ [1,2], [3,4] ] # 2 rows, 2 columns
  m12 = Matrix[ [1,2] ] # 1 row, 2 columns
  m21 = Matrix[ [1], [2] ] # 2 rows, 1 column
  v = Vector[ 1,2 ]

  describe '#element_division' do    
    context 'when dimensions do not match' do
      it 'raises an exception' do
        expect {m23a.element_division m22}.to raise_exception(Matrix::ErrDimensionMismatch)
      end
    end

    context 'when dimensions match' do
      it 'returns correct Matrix' do
        expect(m23a.element_division m23b).to eq Matrix[ [1/2,2/3,3/4], [4/5,5/6,6/7] ]
        expect(m23b.element_division m23a).to eq Matrix[ [2,3/2,4/3], [5/4,6/5,7/6] ]
      end
    end

    context 'when one operator is numeric' do
      it 'returns correct Matrix' do
        expect(m23a.element_division 2).to eq Matrix[ [1/2,2/2,3/2], [4/2,5/2,6/2] ]
      end
    end

    context 'when one operator is a vector' do
      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {m23a.element_division v}.to raise_exception(Matrix::ErrDimensionMismatch)          
        end
      end

      context 'when dimensions match' do
        it 'returns correct Matrix' do
          expect(m21.element_division v).to eq Matrix[ [1],[1] ]
          expect(m12.element_division v).to eq Matrix[ [1,1] ]                              
        end
      end            
    end
  end

  describe '#element_multiplication' do    
    context 'when dimensions do not match' do
      it 'raises an exception' do
        expect {m23a.element_multiplication m22}.to raise_exception(Matrix::ErrDimensionMismatch)
      end
    end

    context 'when dimensions match' do
      it 'returns correct Matrix' do
        expect(m23a.element_multiplication m23b).to eq Matrix[ [1*2,2*3,3*4], [4*5,5*6,6*7] ]
        expect(m23b.element_multiplication m23a).to eq Matrix[ [2,3*2,4*3], [5*4,6*5,7*6] ]
      end
    end

    context 'when one operator is numeric' do
      it 'returns correct Matrix' do
        expect(m23a.element_multiplication 2).to eq Matrix[ [1*2,2*2,3*2], [4*2,5*2,6*2] ]
      end
    end

    context 'when one operator is a vector' do
      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {m23a.element_multiplication v}.to raise_exception(Matrix::ErrDimensionMismatch)          
        end
      end

      context 'when dimensions match' do
        it 'returns correct Matrix' do
          expect(m21.element_multiplication v).to eq Matrix[ [1],[4] ]
          expect(m12.element_multiplication v).to eq Matrix[ [1,4] ]                              
        end
      end            
    end            
  end

  describe '#element_exponentiation' do    
    context 'when dimensions do not match' do
      it 'raises an exception' do
        expect {m23a.element_exponentiation m22}.to raise_exception(Matrix::ErrDimensionMismatch)
      end
    end

    context 'when dimensions match' do
      it 'returns correct Matrix' do
        expect(m23a.element_exponentiation m23b).to eq Matrix[ [1,2**3,3**4], [4**5,5**6,6**7] ]
        expect(m23b.element_exponentiation m23a).to eq Matrix[ [2,3**2,4**3], [5**4,6**5,7**6] ]
      end
    end

    context 'when one operator is numeric' do
      it 'returns correct Matrix' do
        expect(m23a.element_exponentiation 2).to eq Matrix[ [1**2,2**2,3**2], [4**2,5**2,6**2] ]
      end
    end

    context 'when one operator is a vector' do
      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {m23a.element_exponentiation v}.to raise_exception(Matrix::ErrDimensionMismatch)          
        end
      end

      context 'when dimensions match' do
        it 'returns correct Matrix' do
          expect(m21.element_exponentiation v).to eq Matrix[ [1],[4] ]
          expect(m12.element_exponentiation v).to eq Matrix[ [1,4] ]                              
        end
      end            
    end            
  end

  describe '#one' do
    it 'creates matrix with ones' do
      expect(Matrix.one(2, 3)). to eq Matrix[ [1,1,1], [1,1,1] ]
    end
  end

  describe '#hconcat' do
    context 'when input is not a matrix or vector' do
      it 'raises an exception' do
        expect {Matrix.hconcat(m23a, m12, 5)}.to raise_exception(TypeError)                
      end 
    end

    context 'when row dimensions do not match' do
      it 'raises an exception' do
        expect {Matrix.hconcat(m23a, m12)}.to raise_exception(Matrix::ErrDimensionMismatch)                
      end                      
    end

    context 'when row dimensions match' do
      it 'concatenates' do
        expect(Matrix.hconcat(m23a, m22, m23b)).to eq Matrix[ [1,2,3,1,2,2,3,4], [4,5,6,3,4,5,6,7] ]
      end
    end

    context 'when matrix is concatenated with a vector' do
      context 'when dimensions match' do
        it 'concatenates' do
          expect(Matrix.hconcat(m22, v)).to eq Matrix[ [1,2,1], [3,4,2] ]
          expect(Matrix.hconcat(m21, v)).to eq Matrix[ [1,1], [2,2] ]
        end
      end

      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {Matrix.hconcat(m12, v)}.to raise_exception(Matrix::ErrDimensionMismatch)                
        end
      end      
    end
  end

  describe '#vconcat' do
    context 'when input is not a matrix or vector' do
      it 'raises an exception' do
        expect {Matrix.vconcat(m23a, m12, 5)}.to raise_exception(TypeError)                
      end 
    end

    context 'when column dimensions do not match' do
      it 'raises an exception' do
        expect {Matrix.vconcat(m23a, m21)}.to raise_exception(Matrix::ErrDimensionMismatch)                
      end                      
    end

    context 'when column dimensions match' do
      it 'concatenates' do
        expect(Matrix.vconcat(m23a, m23b)).to eq Matrix[ [1,2,3], [4,5,6], [2,3,4], [5,6,7] ]
      end
    end

    context 'when matrix is concatenated with a vector' do
      context 'when dimensions match' do
        it 'concatenates' do
          expect(Matrix.vconcat(m12, v)).to eq Matrix[ [1,2], [1,2] ]
        end
      end

      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {Matrix.vconcat(m21, v)}.to raise_exception(Matrix::ErrDimensionMismatch)                
        end
      end      
    end        
  end

  describe '#hpop' do
    context 'when number of columns equal number of columns to be popped' do
      it 'raises an exception' do
        expect {m23a.hpop(3)}.to raise_exception(Matrix::ErrDimensionMismatch)                
      end
    end

    context 'when number of columns are smaller than number of columns to be popped' do
      it 'raises an exception' do
        expect {m23a.hpop(4)}.to raise_exception(Matrix::ErrDimensionMismatch)                
      end
    end

    context 'when number of columns are greater than number of columns to be popped' do
      m23c = m23a.clone
      m23d = m23a.clone

      it 'pops matrix destructively and returns matrix of dropped columns' do
        expect(m23c.hpop).to eq Matrix[ [3], [6] ]
        expect(m23c).to eq Matrix[ [1,2], [4,5] ]
        expect(m23d.hpop(2)).to eq Matrix[[2, 3], [5, 6]]
        expect(m23d).to eq Matrix[ [1], [4] ]        
      end
    end
  end

  describe '#vpop' do
    context 'when number of rows equal number of rows to be popped' do
      it 'raises an exception' do
        expect {m23a.vpop(2)}.to raise_exception(Matrix::ErrDimensionMismatch)                
      end
    end

    context 'when number of rows are smaller than number of rows to be popped' do
      it 'raises an exception' do
        expect {m23a.vpop(3)}.to raise_exception(Matrix::ErrDimensionMismatch)                
      end
    end

    context 'when number of rows are greater than number of rows to be popped' do
      m23e = m23a.clone

      it 'pops matrix destructively and returns updated matrix' do
        expect(m23e.vpop).to eq Matrix[ [4,5,6] ]        
        expect(m23e).to eq Matrix[ [1,2,3] ]        
      end
    end
  end

  describe '#vcopy' do
    context 'when no argument is given' do
      m23f = m23a.clone           

      it 'copies rows one time' do
        expect(m23f.vcopy).to eq Matrix[[1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6]] 
        expect(m23f).to eq Matrix[[1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6]]                
      end
    end

    context 'when number of copies equals 3' do
      m23g = m23a.clone      
      
      it 'copies rows 3 times' do
        expect(m23g.vcopy(3)).to eq Matrix[[1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6]]
        expect(m23g).to eq Matrix[[1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6], [1, 2, 3], [4, 5, 6]]                                                
      end      
    end    
  end

  describe '#hcopy' do
    context 'when no argument is given' do
      m23h = m23a.clone           

      it 'copies columns one time' do
        expect(m23h.hcopy).to eq Matrix[[1, 2, 3, 1, 2, 3], [4, 5, 6, 4, 5, 6]]
        expect(m23h).to eq Matrix[[1, 2, 3, 1, 2, 3], [4, 5, 6, 4, 5, 6]]
      end
    end

    context 'when number of copies equals 3' do
      m23i = m23a.clone      
      
      it 'copies columns 3 times' do
        expect(m23i.hcopy(3)).to eq Matrix[[1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3], [4, 5, 6, 4, 5, 6, 4, 5, 6, 4, 5, 6]]
        expect(m23i).to eq Matrix[[1, 2, 3, 1, 2, 3, 1, 2, 3, 1, 2, 3], [4, 5, 6, 4, 5, 6, 4, 5, 6, 4, 5, 6]]
      end      
    end    
  end              
end