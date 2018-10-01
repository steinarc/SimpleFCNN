#This script writes the sigmoid function memory. The sigmoid function is 1.0/(1.0 + exp(-x)) 
#The input is a value between -inf and inf. The output is between 0 and 1
#dataWidth is dynamic. Since the output always is less than 1, each memory entry is of the form [dataWidth,dataWidth]
#An input value greater than 4 means output = 1 and saturation is reached. Less than -4 means output = 0

import numpy as np

if __name__== "__main__":
    dataWidth = 4
    fileName = "sigmoidMemory.txt"
    rang = np.arange(-4,4,8*2**(-dataWidth)) #Create range with stepsize
    sig = [0] * 2**dataWidth
    k = 0
    for i in np.nditer(rang):
        sig[k] = (1.0/(1.0 + np.exp(-i)))
        k += 1

    print(sig)
    print(len(sig))

    sig_shifted = [0] * 2**dataWidth
	k = 0
	for i in np.nditer(rang):
		sig_shifted[k] = sig[k] * 2**(dataWidth)
		k += 1
     
    print(sig_shifted)
    print(len(sig_shifted))
      
"""    sig_quantized = sig_shifted
    for i in range (0, 2**dataWidth):
        sig_quantized[i] = np.floor(sig_shifted[i])

    print(sig_quantized)
    print(len(sig_quantized))
"""
    f = open(fileName,'w')


    #Use bin() function to convert to binary

