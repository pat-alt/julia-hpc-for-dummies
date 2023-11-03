using MPI
MPI.Init()

comm = MPI.COMM_WORLD

if MPI.Comm_rank(comm) == 0
   println(VERSION)

   # Multi-threading:
   a = zeros(10)
   Threads.@threads for i = 1:10
      a[i] = Threads.threadid()
   end

   println(a)

end

MPI.Barrier(comm)

# MPI:
println("Hello world 🌍, I am rank $(MPI.Comm_rank(comm)) of world $(MPI.Comm_size(comm)).\n")
MPI.Barrier(comm)

println("P$(MPI.Comm_rank(comm)) behind barrier 🚪.\n")

MPI.Finalize()
