function plotPerf(ax, block)
%PLOTPERF Summary of this function goes here
%   Detailed explanation goes here
[block.trial(arrayfun(@(a)isempty(a.contrastLeft), block.trial)).contrastLeft] = deal(nan);
[block.trial(arrayfun(@(a)isempty(a.contrastRight), block.trial)).contrastRight] = deal(nan);
[block.trial(arrayfun(@(a)isempty(a.response), block.trial)).response] = deal(nan);
[block.trial(arrayfun(@(a)isempty(a.response), block.trial)).responseTimes] = deal(nan);
[block.trial(arrayfun(@(a)isempty(a.response), block.trial)).stimulusOnTimes] = deal(nan);

contrast = [];
contrast(1,:) = [block.trial.contrastLeft];
contrast(2,:) = [block.trial.contrastRight];

response = [block.trial.response];
repeatNum = [block.trial.repeatNum];
incl = ~any(isnan([contrast;response;repeatNum]));
contrast = contrast(:,incl);
response = response(incl);
% repeatNum = repeatNum(incl);

trialstart = 1:numel(response);
dcontrast = diff(contrast, [], 1);


% Find choice types

% First plot the time-outs
cla(ax)
timeouts = find(response == 0);
plot(ax, trialstart(timeouts), dcontrast(timeouts), 'ko', 'MarkerFaceColor', 'k');
hold on

% Plot the correct/incorrect trials
corr = find(response ~= 0 & sign(dcontrast) == response);
incorr = find(response ~= 0 & sign(dcontrast) ~= response);
plot(ax, trialstart(corr), dcontrast(corr), 'bo', 'MarkerFaceColor', 'b');
plot(ax, trialstart(incorr), dcontrast(incorr), 'ro', 'MarkerFaceColor', 'r');
set(ax, 'XLim', [0 max(50, numel(response))]);

% Plot the response times
responseTimes = [block.trial.responseTimes];
%disp(responseTimes)
responseTimes = responseTimes(2:end);

stimOnTimes = [block.trial.stimulusOnTimes];
%disp(stimOnTimes);
n = min(numel(responseTimes) - 1, numel(stimOnTimes));
rt = responseTimes(1:n) - stimOnTimes(1:n);

plot(ax, 3:numel(rt) + 2, rt, 'r');
% Visualize the behavior
% xlabel('Time (min)');
% set(gcf, 'Position', [200 300 1500 500])
% set(gca, 'PlotBoxAspectRatio', [30 10 1]);
% set(ax, 'OuterPosition', [0. 0 1 1]);
% set(ax,'YTick', [0 1])
% set(ax,'YTickLabel',{'Left','Right'})


end

