function compute_log_return_table(data_table::DataFrame,  date_key::Symbol, data_key::Symbol)::DataFrame
    
    # get the size of the table -
    (number_of_rows, number_of_cols) = size(data_table)

    # initialize -
    return_array = Array{Float64,1}()
    date_array = Array{Date,1}()

    # compute -
    for row_index = 2:number_of_rows
        
        # setup -
        today_index = row_index
        yesterday_index = row_index - 1
    
        # compute the return -
        close_price_today = data_table[today_index,data_key]
        close_price_yesterday = data_table[yesterday_index,data_key]
        value = log(close_price_today/close_price_yesterday)
        push!(return_array, value)

        # grab te date -
        today_timestamp = data_table[today_index,date_key]
        push!(date_array, today_timestamp)
    end

    # build data frame and return -
    return_table = DataFrame(timestamp=date_array, log_return=return_array)
    return return_table
end