a = zeros(10)
Threads.@threads for i = 1:10
    a[i] = Threads.threadid()
    sleep(20)
end

println(a)
