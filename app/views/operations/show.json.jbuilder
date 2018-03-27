json.partial! "operations/operation", operation: @operation
json.ration do 
    json.partial! "rations/ration", ration: @ration
end

json.requests do
    json.array! @regional_requests, partial: 'regional_requests/regional_request', as: :regional_request    
end

json.requisitions do
    json.array! @requisitions, partial: 'requisitions/requisition', as: :requisition    
end