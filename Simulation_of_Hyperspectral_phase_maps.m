clc
clear all 
close ('all')
A=1.4580;
B=0.00354;
C=-5.16E-5;
for lambda=0.460:0.002:0.900

n_2=A+(B./((lambda).^2))+(C./(lambda).^4);


gridSize=512;    % Size of the grid
r0= 100;
r02=300;

    % Create a grid
    x = linspace(-gridSize/2, gridSize/2, gridSize);
    [X, Y] = meshgrid(x, x);

circ1 = double(sqrt((X-50).^2+(Y-50).^2)<r0);
% circ2 = double(sqrt(X.^2+Y.^2)<r02);
n2=circ1.*n_2;
%     figure 
%     imagesc(circ1)
    n1=circ1.*1.000277;
    d=0.16E-6;
phi=((2*pi)/(lambda*10^(-6))).*((n2-n1).*d);

saving_Sample = strcat(num2str(lambda*1000),'_Sample.mat')
save (saving_Sample,"phi")
figure, mesh (phi); axis image; colormap("jet"); colorbar; title("Phase");
end

for i=460:2:900
      load([num2str(i) '_Sample.mat']) 
%    sprintf('A%dnm', i) =QW2;
% filename= sprintf('A%dnm', i);
  assignin('base', sprintf('QPI_%d', i), phi);
end
figure, imagesc(phi); axis image; colormap("jet"); colorbar; title("Phase");

Collection=QPI_460;
for l=462:2:900
       A_name=sprintf('QPI_%d', l);
    B_coll= eval(A_name);
   Collection=cat (3,Collection,B_coll);
end
%%
% saving a 3d Plot
grayImage=Collection(:,100:420,40);
grayImage(grayImage<0)=0;
% Create a mesh plot from the grayscale image
[X, Y] = meshgrid(1:size(grayImage, 2), 1:size(grayImage, 1));
Z = double(grayImage);

% Create a continuous mesh plot
figure;
mesh(X, Y, Z, 'EdgeColor', 'none', 'FaceColor', 'interp');
% title('Continuous Mesh Plot Image');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Intensity');

% Customize appearance 
colormap('jet');    % Change colormap
colorbar;            % Show colorbar
axis tight;          % Adjust axis limits
view(38, 77);        % Set viewing angle

% Save the figure as a TIFF file
% saveas(gcf, 'Cell1_3D_view angle_38_77.tif', 'tiff');




% figure 
% imagesc(Collection(:,:,40));
Y1=squeeze(Collection(271,299,:));
lambda=[460:2:900];
plot(lambda,Y1)

lambda2= transpose (lambda)./1000;
