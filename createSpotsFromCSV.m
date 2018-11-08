%  Installation:
%  - Copy this file into the XTensions folder in the Imaris installation directory.
%  - You will find this function in the Image Processing menu
%
%    <CustomTools>
%      <Menu>
%       <Submenu name="Spots Functions">
%        <Item name="Create Channel From CSV" icon="Matlab">
%          <Command>MatlabXT::createSpotsFromCSV(%i)</Command>
%        </Item>
%       </Submenu>
%      </Menu>
%      <SurpassTab>
%        <SurpassComponent name="bpSpots">
%          <Item name="Create Channel From CSV" icon="Matlab">
%            <Command>MatlabXT::createSpotsFromCSV(%i)</Command>
%          </Item>
%        </SurpassComponent>
%      </SurpassTab>
%    </CustomTools>
% 
%

function createSpotsFromCSV(aImarisApplicationID)

% connect to Imaris interface
if ~isa(aImarisApplicationID, 'Imaris.IApplicationPrxHelper')
  javaaddpath ImarisLib.jar
  vImarisLib = ImarisLib;
  if ischar(aImarisApplicationID)
    aImarisApplicationID = round(str2double(aImarisApplicationID));
  end
  vImarisApplication = vImarisLib.GetApplication(aImarisApplicationID);
else
  vImarisApplication = aImarisApplicationID;
end

% grab the surpass scene from Imaris
vSurpassScene = vImarisApplication.GetSurpassScene;

vImarisApplication.DataSetPushUndo('Create Channel from Text');

%% The following MATLAB code creates a new Spots object
vSpots=vImarisApplication.GetFactory.CreateSpots;

% opens a dialogue box to have user select csv file containing the xyz-positions
% note : input files can only be csv files
[filename, pathname] = uigetfile('*.csv','Select the input csv file containing the xyz-positions');
infile = strcat(pathname, filename);
% assign position variables from csv file
Nrows = numel(textread('mydata.txt','%1c%*[^\n]'))
dataset = csvread(infile,4,0);
data_dim = size(dataset);
datalen = data_dim(1);
xpos_data = dataset(:,1)
ypos_data = dataset(:,2);
zpos_data = dataset(:,3);

% create place holder for the new channel
vSpotsXYZ=[xpos_data ypos_data zpos_data];

% create place holder for time indices
% assumes only 1 time point
%% TODO: allow for multiple time points
aIndicesT=zeros(datalen,1);

% dialogue box for user defined spots radius
prompt = {'Enter Spot Radius:'};
dlg_title = 'Spot Radius';
num_lines = 1;
defaultans = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);

spotrad=str2double(answer);

% assign sphere radius of 1.5 as default
%vSpotsRadius=1.5*ones(datalen,1);
vSpotsRadius=spotrad*ones(datalen,1);
% assign the spots object its positions, time indices and size
vSpots.Set(vSpotsXYZ,aIndicesT,vSpotsRadius);

% Give the component a nice name
vSpotsComponent.SetName('Spots from XTCreateSpotsFromFile');
  
% Set red color
vSpotsComponent.SetColorRGBA(255);

% Add the spots component at the end of the surpass tree
vScene.AddChild(vSpotsComponent, -1);  






