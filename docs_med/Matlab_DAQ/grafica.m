function grafica(src, evt)
% plot the signal
plot(evt.TimeStamps, evt.Data, 'r')
grid minor
ylim([-0.01 0.01])
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Tiempo, s')
ylabel('Amplitud, V')
% check if the user wants to stop the DAQ-session
% i.e., if the "Esc" key is pressed by the user
k = get(gcf, 'CurrentKey');
if strcmp(k, 'escape')
    stop(src)
    return
end
end