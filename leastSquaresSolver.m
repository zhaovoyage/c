function [receiverPosition, receiverClockBias] = leastSquaresSolver(satelliteXYZ, pseudorange, weights)
    % Input:
    %   satelliteXYZ: 卫星的xyz坐标矩阵，每一列对应一个卫星的坐标 [X1, Y1, Z1; X2, Y2, Z2; ...]
    %   pseudorange: 接收机到各个卫星的伪距向量 [PR1, PR2, ...]
    %   weights: 加权矩阵，对伪距的测量进行加权
    % Output:
    %   receiverPosition: 接收机位置 [X, Y, Z]
    %   receiverClockBias: 接收机钟差

    % 检查输入参数的维度是否匹配
    if size(satelliteXYZ, 1) ~= length(pseudorange) || size(satelliteXYZ, 1) ~= size(weights, 1)
        error('输入参数维度不匹配');
    end

    % 加权最小二乘求解
    A = [satelliteXYZ, ones(size(satelliteXYZ, 1), 1)];
    b = pseudorange;
    W = diag(weights);

    % 加权最小二乘解算
    x = (A' * W * A) \ (A' * W * b);

    % 提取解算结果
    receiverPosition = x(1:3);
    receiverClockBias = x(4);
end
