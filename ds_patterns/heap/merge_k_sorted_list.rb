# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val = 0, _next = nil)
#         @val = val
#         @next = _next
#     end
# end
# @param {ListNode[]} lists
# @return {ListNode}
#
#
def merge(list1, list2)
  return list1 if list2.nil?
  return list2 if list1.nil?

  head = ListNode.new()
  current = head

  while list1 && list2
    if list1.val < list2.val
      current.next = list1
      current = current.next
      list1 = list1.next

    else
      current.next = list2
      current = current.next
      list2 = list2.next
    end
  end
  current.next = list1 || list2


  head.next
end

def merge_k_lists(lists)
  return nil if lists.size == 0
  return lists.first if lists.size == 1

  merged_lists = []

  loop do
    iterator = 0
    while (iterator < lists.size) do
      merged_lists << merge(lists[iterator], lists[iterator + 1])
      iterator += 2
    end

    break if merged_lists.size == 1
    lists = merged_lists
    merged_lists = []

  end

  merged_lists.first
end