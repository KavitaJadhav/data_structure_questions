# @param {String} word1
# @param {String} word2
# @return {Integer}

# validate my understanding 1. source and target index same - take source/taget index character,
# 2. insert - word 2 incomplete and word1 compete or dp represent insert
# 3. delete - if word2 complete and word1 present or dp represent delete - prefer delete over insert
# 4. replace - default behaviour - (actually based on dp but since all conditioned handeled it works with else)

# insert - result_dp[word2_index + 1][word1_index]
# delete - result_dp[word2_index][word1_index + 1]
# replace -result_dp[word2_index + 1][word1_index + 1]
# INSERT   → (i+1, j)
# DELETE   → (i, j+1)
# REPLACE  → (i+1, j+1)
# MATCH    → (i+1, j+1)
# i = target
# j = source

def min_distance(word1, word2)
  return word1.length if word2.length == 0
  return word2.length if word1.length == 0

  result_dp = Array.new(word2.length + 1) {Array.new(word1.length + 1, 0)}

  word2_index = word2.length
  word1_index = word1.length

  for index in 0..word2.length
    result_dp[index][word1_index] = word2.length - index
  end

  for index in 0..word1.length
    result_dp[word2_index][index] = word1.length - index
  end

  for word2_index in (word2.length - 1).downto(0)
    for word1_index in (word1.length - 1).downto(0)
      if word2[word2_index] == word1[word1_index]

        result_dp[word2_index][word1_index] = result_dp[word2_index + 1] [word1_index + 1]
      else
        result_dp[word2_index][word1_index] = 1 + [
            result_dp[word2_index][word1_index + 1],
            result_dp[word2_index + 1][word1_index],
            result_dp[word2_index + 1][word1_index + 1]
        ].min
      end
    end
  end


  word2_index = 0
  word1_index = 0

  result = []
  while(word1_index < word1.length || word2_index < word2.length) do
    # match
    if(word1_index < word1.length && word2_index < word2.length && (word1[word1_index]==word2[word2_index]))
        result << word1[word1_index]
      word1_index+=1
      word2_index+=1
    elsif

    end
  end
end

