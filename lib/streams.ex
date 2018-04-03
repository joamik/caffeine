defmodule Caffeine.Fibonacci do
    def stream do
        stream(0, 1)
    end
 
    defp stream(a, b) do
        rest = fn -> stream(b, a + b) end
        Caffeine.Stream.construct(a, rest)
    end
end

defmodule Caffeine.Value do
    def stream(n) do
        rest = fn -> stream(n) end
        Caffeine.Stream.construct(n, rest)
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

defmodule Caffeine.Integer do
    def stream(n) when is_integer(n) do
        rest = fn -> stream(increment(n)) end
        Caffeine.Stream.construct(n, rest)
    end

    def stream(_) do
        raise ArgumentError, message: "The argument is not integer"
    end

    defp increment(n) do
        n + 1
    end
end

defmodule Caffeine.Square do
    def stream do
        stream(0)
    end

    defp stream(n) do
        rest = fn -> stream(increment(n)) end
        Caffeine.Stream.construct(square(n), rest)
    end

    defp increment(n) do
        n + 1
    end

    defp square(n) do
        :math.pow(n, 2)
    end
end

# different approach

defmodule Caffeine.Square do
    def stream do
        Caffeine.Natural.stream()
        |> Caffeine.Stream.map(&Caffeine.Square.square/1)
    end

    def square(n) do
        :math.pow(n, 2)
    end
end

defmodule Caffeine.Even do
    require Integer
    # require macro instructs the compiler to load the specified 
    # module before compiling the containing module
    
    def stream do
        Caffeine.Natural.stream() 
        |> Caffeine.Stream.filter(&Integer.is_even/1)
    end
end

defmodule Caffeine.Odd do
    require Integer

    def stream do
        Caffeine.Natural.stream()
        |> Caffeine.Stream.filter(&Integer.is_odd/1)
    end
end

defmodule Caffeine.Range do
    def stream(a, b) when a < b do
        rest = fn -> stream(increment(a), b) end
        Caffeine.Stream.construct(a, rest)
    end

    def stream(a, b) when a == b do
        [a, []]
    end

    def stream(a, b) when a > b do
        raise ArgumentError, message: "The arguments not valid for range"
    end

    defp increment(n) do
        n + 1
    end
end

defmodule Caffeine.List do
    def stream(l) when is_list(l) do
        [head | tail] = l
        rest = fn -> stream(tail) end
        Caffeine.Stream.construct(head, rest)
    end
end

defmodule Caffeine.Factorial do
    def stream do
        nil
    end
end

defmodule Caffeine.PrimeNumber do
    def stream do
        nil
    end
end

defmodule Caffeine.File do
    def stream do
        nil
    end
end