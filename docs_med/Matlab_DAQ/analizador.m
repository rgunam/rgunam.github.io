function analizador(src,evt)


%analisis espectral
w= hamming(length(evt.Data), 'periodic');
[P,f]=periodogram(evt.Data, w, [], get(src,'Rate'), 'power');
P= 20 *log10(sqrt(P)*sqrt(2));

%grafica el espectro
plot(f,P,'r')
grid minor
ylim([-120 20])
xlim([0 max(f)])
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Frecuencia, Hz')
ylabel('Magnitud, dB')
% check if the user wants to stop the DAQ-session
% i.e., if the "Esc" key is pressed by the user
k = get(gcf, 'CurrentKey');
if strcmp(k, 'escape')
    stop(src)
    return
end
end

