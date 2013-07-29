function [] = kwExt(fNIn,fNOut )
%KWEXT kwExt(fNIn,fNOut ) 
% Extracts keyword values  from the Eclipse keywords file fNIn
%generated by a preprocessors (e.g. Flogrid, Petrel or RMS). The function
%then saves the extracted data in fNOut.

%%
%
[pth rt ext] = fileparts(fNIn);
msg = ['Extracting keywords from realization ' rt '. '];
display(msg);
logIt(msg);
%
KWn=[];
[fid, msg] = fopen(fNIn, 'rt');
   lin = fgetl(fid);       
   % Loop until next keyword
   kw = regexp(lin, '[^a-z_A-Z]+', 'match', 'once');
   while isempty(kw) && ~feof(fid),
       KW = KWn;
       if isempty(KWn) 
           KW = textscan(lin,'%s');
           KW = char(KW{1});
       end
       fNOutKw = [fNOut '_' KW '.INC'];
       [fOid,msg] = fopen(fNOutKw,'w+');
       fprintf(fOid,'%s \n',lin);
       lin = fgetl(fid);       
       kw = regexp(lin, '[^a-z_A-Z]+', 'match', 'once');       
       while ~isempty(kw),
            if lin ~= -1,
                fprintf(fOid,'%s \n',lin);
            end
           if feof(fid), break;end;
           lin = fgetl(fid);   
           while isempty(lin) && ~feof(fid),
               fprintf(fOid,'%s \n',lin);
               lin = fgetl(fid); 
           end
           kw = regexp(lin, '[^a-z_A-Z]+', 'match', 'once');       
       end
       fclose(fOid);       
       if ~feof(fid),
           KWn = textscan(lin,'%s');
           KWn = char(KWn{1});
       end
   end
end

