clc 
clear

pathImage1 = 'C:\Users\acer\Pictures\PCD\UAS 3\FotoJari\Test\*.jpg';

data1 = datastore(pathImage1)

pathImage2 = 'C:\Users\acer\Pictures\PCD\UAS 3\FotoJari\Train\*.jpg';

data2 = datastore(pathImage2)


% Test
test1 = {}

for i = 1:length(data1.Files)
    test1(i) = data1.Files(i)
end

[x, y] = size(test1);

for i = 1 : y 
    gray = rgb2gray(imread(string(test1(i))));
    resize = imresize(gray, [300 300]);
    temp = graycomatrix(resize,'Offset',[2 0]);
    temp = temp(:)';
    [x1,y2] = size(temp);
    for n = 1 : y2
        featureTest(i,n) = temp(n);
    end
end

featureTest

trainTest = featureTest()

% Train
test2 = {}

for i = 1:length(data2.Files)
    test2(i) = data2.Files(i)
end

[x, y] = size(test2);

% Image RGB to GrayScale -> Resize Image -> Feature Train
for i = 1 : y 
    gray = rgb2gray(imread(string(test2(i))));
    resize = imresize(gray, [300 300]);
    temp = graycomatrix(resize,'Offset',[2 0]);
    temp = temp(:)';
    [x1,y2] = size(temp);
    for n = 1 : y2
        featureTrain(i,n) = temp(n);
    end
end

%Output

featureTrain


% LVQ
net = lvqnet(10);
net.trainParam.epochs = 100;
net = train(net,featureTrain,featureTest)
view(net)
