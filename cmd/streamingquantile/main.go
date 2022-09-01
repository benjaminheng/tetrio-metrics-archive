package main

import (
	"encoding/csv"
	"fmt"
	"log"
	"os"
	"strconv"
	"time"

	"github.com/asecurityteam/rolling"
	"github.com/pkg/errors"
)

func main() {
	rows, err := readCSV("../../gamemode_40l.csv")
	if err != nil {
		log.Fatal(err)
	}

	start := time.Now()
	defer func(start time.Time) {
		fmt.Printf("time.Since(start) = %+v\n", time.Since(start))
	}(start)
	window := rolling.NewPointPolicy(rolling.NewWindow(50))
	var count int
	for i := len(rows) - 1; i >= 0; i-- {
		row := rows[i]
		t, err := strconv.ParseFloat(row[1], 64)
		if err != nil {
			log.Fatal(errors.Wrap(err, "parse time to float64"))
		}
		window.Append(t)

		count++
		if count > 50 {
			p50 := int(window.Reduce(rolling.Percentile(50)))
			p90 := int(window.Reduce(rolling.Percentile(10)))
			p95 := int(window.Reduce(rolling.Percentile(5)))
			fmt.Printf("P50 = %+v; P90 = %+v; P95 = %+v\n", p50, p90, p95)
		}
	}
}

func readCSV(filename string) ([][]string, error) {
	f, err := os.Open(filename)
	if err != nil {
		return nil, errors.Wrap(err, "open file")
	}

	r := csv.NewReader(f)
	records, err := r.ReadAll()
	if err != nil {
		return nil, errors.Wrap(err, "read csv file")
	}
	return records[1:len(records)], nil
}
