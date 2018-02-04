# gglensai
Automatic classification of strong gravitational galaxy-galaxy lenses using machine learning.

The main files to use for a test run are:

[trainImg, trainVal] = img_setup(n);
sets up a list of n random images and their corresponding Einstein radii. 

You can view a sample of the images using:
 
draw_sample(imgs,vals);
 

The network can be trained using a set of images with:
 
net = net_setup(trainImg, trainVal);

Lastly, you can test the network using:
 
 
net_test(net, testImg, testVal)
which will display a histogram of the differences between the network output and the generation parameters. It also outputs a list of the first 100 values found by the network.

