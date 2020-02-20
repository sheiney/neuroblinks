function fieldname = device2fieldname(device)
    
    switch device
        case 'Current'
            fieldname = 'e';
        case 'LED'
            fieldname = 'l';
        case 'Laser'
            fieldname = 'l';
    end

end