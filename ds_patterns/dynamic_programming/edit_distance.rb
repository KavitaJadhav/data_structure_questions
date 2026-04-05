# @param {String} word1
# @param {String} word2
# @return {Integer}
def min_distance(word1, word2)
  return word1.length if word2.length==0
  return word2.length if word1.length==0

  result_dp = Array.new(word2.length+1){Array.new(word1.length+1, 0)}

  word2_index = word2.length
  word1_index = word1.length

  for index in 0..word2.length
    result_dp[index][word1_index]  = word2.length - index
  end

  for index in 0..word1.length
    result_dp[word2_index][index]  = word1.length - index
  end

  for word2_index in (word2.length-1).downto(0)
    for word1_index in (word1.length-1).downto(0)
      if word2[word2_index]==word1[word1_index]

        result_dp[word2_index][word1_index] = result_dp[word2_index + 1]        [word1_index+1]
      else
        result_dp[word2_index][word1_index] = 1 + [
            result_dp[word2_index][word1_index+1] ,
            result_dp[word2_index+1][word1_index] ,
            result_dp[word2_index+1][word1_index+1]
        ].min
      end
    end
  end


  result_dp[0][0]
end

