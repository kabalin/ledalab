function [time, conductance, event] = getuserdefdata(fullpathname)
%
%   SCMD data importing function
%
conductance=[];
time=[];
event=[];

iLine = 0;
iEvent = 0;
fid = fopen(fullpathname);
while  ~feof(fid)
    tline = fgetl(fid);
    if strread(tline,'%c') ~= '#'
        line = textscan(tline,'%s','delimiter','\t');
        [Y, M, D, H, MN, S] = datevec(line{1}(1));
        timestr = H*3600 + MN*60 + S;
        if size(line{1},1) > 2
            iEvent = iEvent + 1;
            event(iEvent).time = timestr;
            event(iEvent).nid = iEvent;
            event(iEvent).name = strcat(char(line{1}(2)),'-',char(line{1}(3)));
            event(iEvent).userdata = char(line{1}(4));
        else
            iLine = iLine + 1;
            time(iLine) = timestr;
            conductance(iLine) = str2double(line{1}(2));
        end
    end
end
fclose(fid);
