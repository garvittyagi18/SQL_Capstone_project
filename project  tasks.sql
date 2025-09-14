--                                               Hospital Patient Management System



--  1.  Retrieve a list of all patients  who have visited the hospital in the last six months.


SELECT DISTINCT pat.patient_id, pat.name, pat.gender, pat.phone, pat.address
FROM Patients pat, Appointments app
WHERE pat.patient_id = app.patient_id
AND app.appintment_date BETWEEN '2024-03-01' AND '2024-09-01';



-- 2.  List the details of doctors along with their specializations  and the number of patients they have treated.

SELECT doc.doctor_id, doc.name, doc.specialization,
COUNT(app.patient_id) AS total_patients
FROM Doctors doc
LEFT JOIN Appointments app ON doc.doctor_id = app.doctor_id
GROUP BY doc.doctor_id, doc.name, doc.specialization;




-- 3.  Find all appointments scheduled for 'Dr. Mehta' on 'March 15, 2024',  including patient details and appointment time.

SELECT app.appintment_id, pat.name AS patient_name, app.appintment_date, 
       app.appointment_time, app.reason
FROM Appointments app
JOIN Doctors doc ON app.doctor_id = doc.doctor_id
JOIN Patients pat ON app.patient_id = pat.patient_id
WHERE doc.name = 'Dr. Mehta' 
  AND app.appintment_date = '2024-03-15';


-- 4.    Identify patients who have been admitted for more than 10 days and calculate their total billing amount.


SELECT pat.name, adm.admission_id,
DATEDIFF(IFNULL(adm.ddischarge_date, '2024-09-01'), adm.admission_date) AS total_days, bill.total_amount
FROM Admissions adm
JOIN Patients pat ON adm.patient_id = pat.patient_id
JOIN Billing bill ON adm.admission_id = bill.admission_id
WHERE DATEDIFF(IFNULL(adm.ddischarge_date, '2024-09-01'), adm.admission_date) > 10;



-- 5.   List all available hospital rooms  and their current occupancy status.

SELECT r.room_id, r.room_type,
       IF(r.is_occupied = 1, 'Occupied', 'Available') AS room_status
FROM Rooms r;


-- 6.   Retrieve the complete medical history of a specific patient, including past illnesses, prescriptions, and treatments.

SELECT p.name, mh.illness, mh.diagnosis_date, mh.treatment,
       pr.medication, pr.dosage, pr.prescribed_date
FROM patients p, medical_history mh, prescriptions pr
WHERE p.patient_id = mh.patient_id 
AND p.patient_id = pr.patient_id
AND p.name = 'Amit Sharma';




-- 7.  Find all emergency room visits in the last month, along with reasons for admission and attending doctors.


SELECT p.name AS patient_name, 
       a.admission_date, 
       ap.reason, 
       d.name AS doctor_name
FROM patients p, admissions a, doctors d, rooms r, appointments ap
WHERE p.patient_id = a.patient_id
AND a.doctor_id = d.doctor_id
AND a.room_id = r.room_id
AND ap.patient_id = p.patient_id
AND ap.doctor_id = a.doctor_id
AND r.room_type = 'ICU'
AND a.admission_date BETWEEN '2024-08-01' AND '2024-09-30';



-- 8.   List all patients who have been prescribed 'Amoxicillin' in the past three months.

SELECT p.patient_id, p.name, pr.medication, pr.prescribed_date
FROM patients p
LEFT JOIN prescriptions pr 
    ON p.patient_id = pr.patient_id 
   AND pr.medication = 'Amoxicillin'
   AND pr.prescribed_date BETWEEN '2024-07-01' AND '2024-09-30';
   
   
-- 9.    Retrieve all pending medical test reports, including the test type and expected report delivery date.

SELECT p.patient_id, p.name, m.illness, m.diagnosis_date,
       CASE
           WHEN a.ddischarge_date IS NULL THEN 'Pending'
           ELSE 'Completed'
       END AS report_status
FROM patients p
JOIN medical_history m ON p.patient_id = m.patient_id
LEFT JOIN admissions a ON p.patient_id = a.patient_id;


-- 10.   Identify the department with the highest number of patientn admissions in the past year.

SELECT d.department_name, COUNT(a.admission_id) AS total_admissions
FROM Admissions a
JOIN Doctors doc ON a.doctor_id = doc.doctor_id
JOIN Departments d ON doc.department_id = d.department_id
WHERE a.admission_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY d.department_name
ORDER BY total_admissions DESC
LIMIT 1;


-- 11.  Find the names of patients who have visited multiple doctors for the same illness.

SELECT p.patient_id, 
       p.name AS patient_name, 
       a.reason AS illness
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, a.reason
HAVING COUNT(DISTINCT a.doctor_id) > 1;


-- 12.  List all staff members working in the 'Cardiology' department,  along with their roles and shift timings.

SELECT s.staff_id,
       s.name AS staff_name,
       d.department_name,
       s.role,
       s.shift_start,
       s.shift_end
FROM Staff s
JOIN Departments d ON s.department_id = d.department_id
WHERE d.department_name = 'Cardiology';



-- 13.  Find the number of surgeries performed in the last six months, categorized by type of surgery.

SELECT a.reason AS surgery_type,
       COUNT(*) AS total_surgeries
FROM Appointments a
WHERE a.reason LIKE '%Surgery%'
  AND a.appintment_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY a.reason;

-- Task - 14	Retrieve a report of all prescriptions issued by a specific doctor within a given date range.

select p.prescription_id, p.patient_id, pa.name as patient_name, d.doctor_id, d.name as doctor_name,
p.medication, p.dosage, p.prescribed_date from prescriptions p 
join patients pa on p.patient_id = pa.Patient_id
join doctors d on p.doctor_id = d.doctor_id 
where d.name = 'Dr. Mehta' and p.prescribed_date between '2024-01-01' and '2024-12-31'
order by p.prescribed_date;

-- Task - 15  Identify the most commonly diagnosed illness based on patient records.

select illness, count(*) as illness_count
from medical_history group by illness
order by illness_count desc 
limit 1;

-- Task - 16.Generate a report showing hospital revenue generated from outpatient consultations, surgeries, and diagnostic tests.

select sum(consultation_fee) as rev_outpatient_consultations, sum(treatment_cost) as rev_surgeries, 
sum(room_charges) as rev_room_charges from billing;

-- Task - 17.	Ensure that when a patient is discharged, their final bill is updated correctly, including consultation fees, 
--              treatment costs, and room charges.
DELIMITER //
create trigger update_final_bill
after update on admissions 
for each row
begin
if NEW.discharge_date is not null then 
update billing 
set total_amount = consultation_fee + treatment_cost + room_charges
where admission_id = NEW.admission_id;
end if;
end //
DELIMITER ;

-- Task - 18.	Automatically notify doctors if a critical patient's vital signs drop below a safe threshold.

DELIMITER //
create trigger alert_critical_vitals
after insert on vital_signs
for each row
begin
if new.heart_rate < 50 or new.heart_rate > 120
or new.oxygen_level < 92
or new.temperature > 39 or new.temperature < 35 then 
insert into critical_alerts (patient_id, admission_id, alert_time, alert_message)
values (new.patient_id, new.admission_id, now(), 'Critical vital signs detected');
end if;
end //
DELIMITER ;

-- Task - 19.	Ensure that no duplicate patient records are created when registering a new patient.

alter table patients
add constraint unique_patient unique(`name`, dob, phone);

-- Task - 20.	Update room availability immediately when a patient is admitted or discharged.
-- 0 for occupied and 1 for availability 

DELIMITER //
create trigger update_room_on_admit
after insert on admissions
for each row 
begin
update rooms 
set is_occupied = 0
where room_id = new.room_id;
end //
DELIMITER ;

DELIMITER //
create trigger update_room_on_discharge
after update on admissions
for each row
begin
if new.discharge_date is not null then
update rooms
set is_occupied = 1
where room_id = new.room_id;
end if;
end //
DELIMITER ;

-- Task - 21.	Verify that all prescribed medications are available in the pharmacy before issuing them to a patient.

select p.prescription_id, p.medication, p.quantity as required_qty, pi.available_quantity
from prescriptions p join pharmacy_inventory pi on p.medication = pi.medicine_name;

-- Task - 22.	Ensure that only authorized hospital staff can modify or delete sensitive patient records.

create role doctor_role, nurse_role;

grant select, update, delete on patients to doctor_role;
grant select, update, delete on patients to nurse_role;

-- Task - 23.	Create an alert if a patient misses a scheduled follow-up appointment.

DELIMITER //
create trigger missed_appointment_alert
after update on appointments
for each row
begin
if new.`status` = 'Missed' and old.`status` = 'Scheduled' then
insert into appointment_alerts(appointment_id, patient_id, doctor_id, alert_message)
values (new.appointment_id, new.patient_id, new.doctor_id,
concat('Pateint', new.patient_id, 'missed follow-up appointment on', new.appintment_date));
end if;
end //
DELIMITER ;

-- Task - 24.	Automatically update hospital inventory when new medical supplies are received or used.

DELIMITER //
create trigger update_inventory_after_transaction
after insert on inventory_transaction
for each row 
begin
if new.transaction_type = 'Received' then
update medical_inventory
set available_quantity = available_quantity + new.quantity
where supply_id = new.supply_id;
elseif new.transaction_type = 'Used' then
update medical_inventory 
set available_quantity = available_quantity - new.quantity
where supply_id = new.supply_id;
end if;
end //
DELIMITER ;

-- Task - 25.	Generate a monthly report summarizing patient admissions, treatments, and medical trends.
SET SESSION sql_mode = (SELECT REPLACE(@@SESSION.sql_mode, 'ONLY_FULL_GROUP_BY', ''));

select year(a.admission_date) as report_year, month(a.admission_date) as report_month,
count(distinct a.patient_id) as total_patient, count(*) as total_admission, 

(select count(*) 
 from medical_history mh
where year(mh.diagnosis_date) = year(a.admission_date) and 
month(mh.diagnosis_date) = month(a.admission_date)
) as total_treatments,
(select m.illness from medical_history m 
where year(m.diagnosis_date) = year(a.admission_date) and
month(m.diagnosis_date) = month(a.admission_date)
group by m.illness order by count(*) desc limit 1) as most_common_illness

from admissions a group by year(a.admission_date), month(a.admission_date)
order by report_year desc, report_month desc;


-- Task - 26.	Ensure that when a patient is discharged, their final bill is 
-- updated correctly, including consultation fees, treatment costs, and room charges.

DELIMITER //
create trigger update_final_bill
after update on admissions 
for each row
begin
if NEW.discharge_date is not null then 
update billing 
set total_amount = consultation_fee + treatment_cost + room_charges
where admission_id = NEW.admission_id;
end if;
end //
DELIMITER ;


--    THANK YOU    --
