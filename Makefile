# Makfile for CCL

NVCC = /usr/local/cuda/bin/nvcc
CC = g++

#FLAGS += -arch sm_13  		# Newest Architecture
FLAGS += -arch sm_30  		# Newest Architecture
#FLAGS += -keep			# Keep intermediate files
#FLAGS += --ptxas-options="-v"	# Show register usage and ptx verbose compilation
FLAGS += -O3

#FLAGS += -g			# Debug mode
#FLAGS += -DLOCAL_DEBUG

#FLAGS += -I.			
FLAGS += -prec-div=false	# Division is approximate
FLAGS += -prec-sqrt=false	# Square root is approximate
FLAGS += -lcudart		# CUDA Utilities library
FLAGS += --use_fast_math

FLAGS += -L /usr/local/cuda/lib64
FLAGS += -I /usr/local/cuda/include
FLAGS += -Xcompiler -Wall -w

#FLAGS += --maxrregcount 28

all:
	$(NVCC) $(FLAGS) ccl_le.cu -o ccl_le_gpu
	$(NVCC) $(FLAGS) ccl_np.cu -o ccl_np_gpu
	$(NVCC) $(FLAGS) ccl_dpl.cu -o ccl_dpl_gpu
	$(CC) -O3 ccl_le.cpp -o ccl_le_cpu
	$(CC) -O3 ccl_np.cpp -o ccl_np_cpu
	$(CC) -O3 ccl_dpl.cpp -o ccl_dpl_cpu

clean:
	rm -f *~ \#* ccl_dpl_gpu ccl_le_gpu ccl_np_gpu ccl_dpl_cpu ccl_le_cpu ccl_np_cpu
#	rm -f *~ \#* $(TARGET)
