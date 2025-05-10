select    
          payment_method,
          status,
          count(*) AS payment_count,
          sum(amount) as total_amount,
          avg(amount)  as avgrage_payment,
          min(payment_date) as first_payment_date,
          max(payment_date)  as last_payment_date
          from {{ ref('stg_A_payments') }}
          group by payment_method,status
      