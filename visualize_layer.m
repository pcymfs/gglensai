function visualize_layer(net, img, layer, dispsiz)

act = activations(net, img, layer, 'OutputAs', 'channels');
sz = size(act);
act = reshape(act, [sz(1) sz(2) 1 sz(3)]);
montage(mat2gray(act), 'Size', dispsiz);

end