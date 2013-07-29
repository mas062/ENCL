figure;
for i=1:length(CollocationPointsBase),
    subplot(3,5,i);
    plot(tc,vc{i});
end