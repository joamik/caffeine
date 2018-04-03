defmodule Caffeine.Fibonacci do
    def stream do
        stream(0, 1)
    end
 
    defp stream(a, b) do
        rest = fn -> stream(b, a + b) end
        Caffeine.Stream.construct(a, rest)
    end
end

defmodule Caffeine.Natural do
    def stream() do
        stream(0)
    end

    defp stream(n) do
        rest = fn -> stream(increment(n)) end
        Caffeine.Stream.construct(n, rest)
    end

    defp increment(n) do
        n + 1
    end
end