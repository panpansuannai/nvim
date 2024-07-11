#include <cstdio>
#include <istream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
  string removeKdigits(string num, int k) {
    if (k >= num.size()) {
      return "";
    }
    vector<char> stack;

    for (int i = 0; i < num.size(); i += 1) {
      if (k == 0 || stack.size() == 0 || num[i] >= stack.back()) {
        stack.push_back(num[i]);
        continue;
      }
      if (num[i] < stack.back()) {
        k -= 1;
        stack.pop_back();
        stack.push_back(num[i]);
      }
    }
    while (k > 0) {
      stack.pop_back();
      k -= 1;
    }
    return string(stack.begin(), stack.end());
  }
};

int main() {
  Solution s = Solution();
  s.removeKdigits("", 10);
}
