# In this challenge you're going to implement a stack using a linked list.
#
# Add the missing code so that main() runs successfully.

from starkware.cairo.common.registers import get_fp_and_pc

struct Node:
    # A pointer to the next node in the stack.
    # Note that the number after the '=' is the offset from the beginning of the struct,
    # and not a default value. In future versions of Cairo it will be removed.
    member next : Node* = 0

    # The value of the node.
    member value : felt = 1

    # The number of elements in the stack.
    member size : felt = 2

    const SIZE = 3
end

# Returns an empty stack.
func empty_stack() -> (stack : Node*):
    alloc_locals
    local new_node : Node
    assert new_node.next = cast(0, Node*)
    assert new_node.value = 0
    assert new_node.size = 0

    # The usage of get_fp_and_pc() here is necessary in order
    # to access the address of a local variable (&new_node).
    # You can read more about get_fp_and_pc() [here](https://cairo-lang.org/docs/how_cairo_works/functions.html#retrieving-registers).
    let (local __fp__, _) = get_fp_and_pc()
    return (stack=&new_node)
end

# Adds a node to the top of the stack.
# Returns the updated stack (since Cairo is immutable, you can still use the
# old copy of the stack).
func push(stack : Node*, value : felt) -> (stack : Node*):
    alloc_locals
    local new_node : Node
    # Fix and uncomment below.
    assert new_node.next = stack
    assert new_node.value = value
    assert new_node.size = stack.size + 1

    let (__fp__, _) = get_fp_and_pc()
    return (stack=&new_node)
end

# Removes the top element of the stack.
# Returns the updated stack and the element that was removed.
func pop(stack : Node*) -> (stack : Node*, value : felt):
    return (stack=stack.next, value=stack.value)
end

# Returns the value of the n-th element from the top of the stack.
func stack_at(stack : Node*, n : felt) -> (value : felt):
    if n == 0:
        # Add your code here.
        return (stack.value)
    end
    stack_at(stack.next, n - 1)
    # Add your code here.
    return (...)
end

func main() -> ():
    alloc_locals
    # Start with an empty stack.
    let (stack) = empty_stack()
    # Push 1, 10, 100.
    let (stack) = push(stack, 1)
    let (stack) = push(stack, 10)
    let (local stack : Node*) = push(stack, 100)

    # Check the size of the stack.
    assert stack.size = 3

    # Query the stack at indices 0, 1 and 2.
    let (value) = stack_at(stack, 0)
    assert value = 100
    let (value) = stack_at(stack, 1)
    assert value = 10
    let (value) = stack_at(stack, 2)
    assert value = 1

    # Pop the top 2 values (100 and 10) and push 1000.
    let (stack, value) = pop(stack)
    assert value = 100
    let (stack, value) = pop(stack)
    assert value = 10
    let (local stack : Node*) = push(stack, 1000)

    # Query the stack at indices 0 and 1.
    let (value) = stack_at(stack, 0)
    assert value = 1000
    let (value) = stack_at(stack, 1)
    assert value = 1

    return ()
end