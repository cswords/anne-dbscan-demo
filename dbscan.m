function [ class ] = dbscan(dis, eps, minPts)

max_dis = max(max(dis));
if max_dis > 1
    dis = dis/max_dis;
end

m_adjacency = dis <= eps;
l_core = sum(m_adjacency, 2) >= minPts;
m_adjacency_core = m_adjacency(l_core, l_core);

class = zeros(size(dis, 1), 1);

if isempty(m_adjacency_core)
    return
end

g_dbscan = graph(gather(m_adjacency_core));
class_core = conncomp(g_dbscan);

[~, l_assign_core] = min(dis(l_core, :));

if size(class_core) == [1, 1]
    class = class + 1;
    return
end

class = class_core(l_assign_core)';

end