clc
clear all
clear variables
%% loading the set of QPI images 
addpath("C:\Users\Himanshu\Desktop\Resolution chart\Cells\15_07\Hyperspectral\Decoupling exfoliated cell\Cell1\Final phase map"); 
% Replace with the actual path to the directory

for i=460:5:706
      load([num2str(i) 'nm_final']) 
%    sprintf('A%dnm', i) =QW2;
% filename= sprintf('A%dnm', i);
Phase=Phase;
  assignin('base', sprintf('QPI_%d', i), Phase);
end

%% Stacking the images 

Collection=QPI_460;
for l=465:5:900
       A_name=sprintf('QPI_%d', l);
    B_coll= eval(A_name);
   Collection=cat (3,Collection,B_coll);
end
%% visualizing a layer of the phase hypercube
Im1=Collection(:,:,1);
figure, imagesc(Im1); axis on; colormap("jet"); colorbar; title("Phase");
colorbar('FontSize',20); set(gca,'FontSize',20);
% figure, mesh (Im1), colormap jet;colorbar;grid off; title("Phase");
% colorbar('FontSize',20); set(gca,'FontSize',20);

%% ploting the variation
% k= C(100,100,:);635,573
% Full=stackedImage(635,573,:);
Collection1=Collection(200:430,410:680,:);
% figure, imagesc(Collection1); axis on; colormap("jet"); colorbar; title("Phase");


%% Hyperspectral phase profiles for a selected ROI
ROI_Col=ones(89,1);
for N=1:231
for m=1:271
    B_coll_ROI=squeeze(Collection1(N,m,:));
    ROI_Col=(cat (2,ROI_Col,B_coll_ROI));
end 
end

Y=squeeze(Collection(635,573,:));
Y1=transpose(Y);
lambda=[460:5:900];
figure
plot(lambda,Y)
lambda2= transpose (lambda);
