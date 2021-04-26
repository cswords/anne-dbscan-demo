function [class] = DBSCAN(dis, eps, minPts)

m_adjacency = dis <= eps;
l_core = sum(m_adjacency, 2) >= minPts;
m_adjacency_core = m_adjacency(l_core, l_core);

class = zeros(size(dis, 1), 1) - 1;

if isempty(m_adjacency_core)
    return % No core, all noise
end

g_dbscan = graph(gather(m_adjacency_core));
class_core = conncomp(g_dbscan);

[l_assign_dis, l_assign_core] = min(dis(l_core, :));
class = class_core(l_assign_core);
class(l_assign_dis > eps) = - 1;

class = class';

end
