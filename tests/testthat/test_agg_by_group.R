test_that(desc = "agg_by_group test",
                    code={
                      skip_on_oldrel()
      expect_error(agg_by_group(1:4),
  "Don't know how to deal with an object of class integer",fixed=TRUE)
      
    expect_error(agg_by_group(yields),
                "You should provide a data.frame, formula, and a function.",
                fixed=TRUE)
    
    expect_equal(agg_by_group(yields,.~normal,length)[1,2],500)
    # ensure tow groups are identified
    call_func <- agg_by_group(yields,.~normal + weight,length)
    # expect two groups
    expect_equal(length(attributes(call_func)$Groups),2)
                    })




