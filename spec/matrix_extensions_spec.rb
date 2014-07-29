require 'spec_helper'

describe MatrixExtended do
  m23a = MatrixExtended[ [1,2,3], [4,5,6] ] # 2 rows, 3 columns
  m23b = MatrixExtended[ [2,3,4], [5,6,7] ] # 2 rows, 3 columns
  m22 = MatrixExtended[ [1,2], [3,4] ] # 2 rows, 2 columns
  m12 = MatrixExtended[ [1,2] ] # 1 row, 2 columns
  m21 = MatrixExtended[ [1], [2] ] # 2 rows, 1 column
  v = Vector[ 1,2 ]

  describe '#element_division' do    
    context 'when dimensions do not match' do
      it 'raises an exception' do
        expect {m23a.element_division m22}.to raise_exception(MatrixExtended::ErrDimensionMismatch)
      end
    end

    context 'when dimensions match' do
      it 'returns correct Matrix' do
        expect(m23a.element_division m23b).to eq MatrixExtended[ [1/2,2/3,3/4], [4/5,5/6,6/7] ]
        expect(m23b.element_division m23a).to eq MatrixExtended[ [2,3/2,4/3], [5/4,6/5,7/6] ]
      end
    end

    context 'when one operator is numeric' do
      it 'returns correct Matrix' do
        expect(m23a.element_division 2).to eq MatrixExtended[ [1/2,2/2,3/2], [4/2,5/2,6/2] ]
      end
    end

    context 'when one operator is a vector' do
      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {m23a.element_division v}.to raise_exception(MatrixExtended::ErrDimensionMismatch)          
        end
      end

      context 'when dimensions match' do
        it 'returns correct Matrix' do
          expect(m21.element_division v).to eq MatrixExtended[ [1],[1] ]
          expect(m12.element_division v).to eq MatrixExtended[ [1,1] ]                              
        end
      end            
    end
  end

  describe '#element_multiplication' do    
    context 'when dimensions do not match' do
      it 'raises an exception' do
        expect {m23a.element_multiplication m22}.to raise_exception(MatrixExtended::ErrDimensionMismatch)
      end
    end

    context 'when dimensions match' do
      it 'returns correct Matrix' do
        expect(m23a.element_multiplication m23b).to eq MatrixExtended[ [1*2,2*3,3*4], [4*5,5*6,6*7] ]
        expect(m23b.element_multiplication m23a).to eq MatrixExtended[ [2,3*2,4*3], [5*4,6*5,7*6] ]
      end
    end

    context 'when one operator is numeric' do
      it 'returns correct Matrix' do
        expect(m23a.element_multiplication 2).to eq MatrixExtended[ [1*2,2*2,3*2], [4*2,5*2,6*2] ]
      end
    end

    context 'when one operator is a vector' do
      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {m23a.element_multiplication v}.to raise_exception(MatrixExtended::ErrDimensionMismatch)          
        end
      end

      context 'when dimensions match' do
        it 'returns correct Matrix' do
          expect(m21.element_multiplication v).to eq MatrixExtended[ [1],[4] ]
          expect(m12.element_multiplication v).to eq MatrixExtended[ [1,4] ]                              
        end
      end            
    end            
  end

  describe '#element_exponentiation' do    
    context 'when dimensions do not match' do
      it 'raises an exception' do
        expect {m23a.element_exponentiation m22}.to raise_exception(MatrixExtended::ErrDimensionMismatch)
      end
    end

    context 'when dimensions match' do
      it 'returns correct Matrix' do
        expect(m23a.element_exponentiation m23b).to eq MatrixExtended[ [1,2**3,3**4], [4**5,5**6,6**7] ]
        expect(m23b.element_exponentiation m23a).to eq MatrixExtended[ [2,3**2,4**3], [5**4,6**5,7**6] ]
      end
    end

    context 'when one operator is numeric' do
      it 'returns correct Matrix' do
        expect(m23a.element_exponentiation 2).to eq MatrixExtended[ [1**2,2**2,3**2], [4**2,5**2,6**2] ]
      end
    end

    context 'when one operator is a vector' do
      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {m23a.element_exponentiation v}.to raise_exception(MatrixExtended::ErrDimensionMismatch)          
        end
      end

      context 'when dimensions match' do
        it 'returns correct Matrix' do
          expect(m21.element_exponentiation v).to eq MatrixExtended[ [1],[4] ]
          expect(m12.element_exponentiation v).to eq MatrixExtended[ [1,4] ]                              
        end
      end            
    end            
  end

  describe '#ones' do
    it 'creates matrix with ones' do
      expect(MatrixExtended.ones(2, 3)). to eq MatrixExtended[ [1,1,1], [1,1,1] ]
    end
  end

  describe '#zeros' do
    it 'creates matrix with zeros' do
      expect(MatrixExtended.zeros(2, 3)). to eq MatrixExtended[ [0,0,0], [0,0,0] ]
    end
  end

  describe '#zeroes' do
    it 'creates matrix with zeros' do
      expect(MatrixExtended.zeros(2, 3)). to eq MatrixExtended[ [0,0,0], [0,0,0] ]
    end
  end

  describe '#hconcat' do
    context 'when input is not a matrix or vector' do
      it 'raises an exception' do
        expect {MatrixExtended.hconcat(m23a, m12, 5)}.to raise_exception(TypeError)                
      end 
    end

    context 'when row dimensions do not match' do
      it 'raises an exception' do
        expect {MatrixExtended.hconcat(m23a, m12)}.to raise_exception(MatrixExtended::ErrDimensionMismatch)                
      end                      
    end

    context 'when row dimensions match' do
      it 'concatenates' do
        expect(MatrixExtended.hconcat(m23a, m22, m23b)).to eq MatrixExtended[ [1,2,3,1,2,2,3,4], [4,5,6,3,4,5,6,7] ]
      end
    end

    context 'when matrix is concatenated with a vector' do
      context 'when dimensions match' do
        it 'concatenates' do
          expect(MatrixExtended.hconcat(m22, v)).to eq MatrixExtended[ [1,2,1], [3,4,2] ]
          expect(MatrixExtended.hconcat(m21, v)).to eq MatrixExtended[ [1,1], [2,2] ]
        end
      end

      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {MatrixExtended.hconcat(m12, v)}.to raise_exception(MatrixExtended::ErrDimensionMismatch)                
        end
      end      
    end
  end

  describe '#vconcat' do
    context 'when input is not a matrix or vector' do
      it 'raises an exception' do
        expect {MatrixExtended.vconcat(m23a, m12, 5)}.to raise_exception(TypeError)                
      end 
    end

    context 'when column dimensions do not match' do
      it 'raises an exception' do
        expect {MatrixExtended.vconcat(m23a, m21)}.to raise_exception(MatrixExtended::ErrDimensionMismatch)                
      end                      
    end

    context 'when column dimensions match' do
      it 'concatenates' do
        expect(MatrixExtended.vconcat(m23a, m23b)).to eq MatrixExtended[ [1,2,3], [4,5,6], [2,3,4], [5,6,7] ]
      end
    end

    context 'when matrix is concatenated with a vector' do
      context 'when dimensions match' do
        it 'concatenates' do
          expect(MatrixExtended.vconcat(m12, v)).to eq MatrixExtended[ [1,2], [1,2] ]
        end
      end

      context 'when dimensions do not match' do
        it 'raises an exception' do
          expect {MatrixExtended.vconcat(m21, v)}.to raise_exception(MatrixExtended::ErrDimensionMismatch)                
        end
      end      
    end        
  end

  describe '#convert_to_matrix_extended' do
    context 'when input is not a matrix' do
      it 'raises an exception' do
        expect {MatrixExtended.convert_to_matrix_extended(Vector[1,2,3])}.to raise_exception(TypeError)
      end
    end

    context 'when input is a matrix' do
      it 'returns the correct object' do
        expect(MatrixExtended.convert_to_matrix_extended(Matrix[ [1,2,3], [4,5,6] ])).to eq MatrixExtended[ [1,2,3], [4,5,6] ]
      end
    end    
  end                 
end