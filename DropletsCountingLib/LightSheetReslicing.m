%% Part1 reslice
baseDirectory='H:\20180621Betaine grad\selected';
d = dir(baseDirectory);  
isub = [d(:).isdir]; %# returns logical vector  
nameFolds = {d(isub).name}';  
nameFolds(ismember(nameFolds,{'.','..'})) = [];
destDirectory='H:\20180621Betaine grad\resliced';
for i=1:length(nameFolds)
    samplename=nameFolds{i};
    M=ImgSeq2Volume2(fullfile(baseDirectory,samplename));
    N=permute(M,[2 3 1]);
    Volum2ImgSequence(fullfile(destDirectory,samplename),N);
end

%% part2 projection of slices
Projstart=220;
Projstop=250;

for i=1:length(nameFolds)
    samplename=nameFolds{i};
    clear M N;
    M=ImgSeq2Volume2(fullfile(destDirectory,samplename),Projstart,Projstop);
    N=permute(M,[3 1 2]);
    N=max(N);
    N=permute(N,[2 3 1]);
    imwrite(uint16(N),[destDirectory,'\ProjectOf',samplename,'.tiff']);
end
