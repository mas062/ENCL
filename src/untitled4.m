for cs=[...
%         {'C01121'},{'C01221'},{'C01321'},{'C02121'},...
%         {'C02221'},{'C02321'},{'C03121'},{'C03221'},
        {'C03321'}],
    caseName = [char(cs) '_SC001_SCN04'];
    runEcl(caseName);
    if runOk(caseName),
        itsRun(caseName);
        convEclInit(caseName);
        %
        convEclSmry(caseName);
        %
        clcPlt(caseName);
        %
        pltClcDone(caseName);
        %
        zipRst(caseName);
        %
        rmRst(caseName);
        %
    end
end
caseName ='C01113_SC001_SCN04';

convEclInit(caseName);
%
convEclSmry(caseName);
%
clcPlt(caseName);
%
pltClcDone(caseName);
%
zipRst(caseName);
%
rmRst(caseName);
%  
mkAllRV('SCN04');
mkAllCP('SCN04');

