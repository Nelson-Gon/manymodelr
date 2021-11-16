test_that(desc = "agg_by_group test",
                    code={
                      skip_on_oldrel()
    expect_snapshot({
      expect_error(agg_by_group(1:4))
      expect_error(agg_by_group(yields))
      
    })                  
expect_equal(agg_by_group(yields,.~normal,length)[1,2],500)
# ensure tow groups are identified
call_func <- agg_by_group(yields,.~normal + weight,length)
# expect two groups
expect_equal(length(attributes(call_func)$Groups),2)})




