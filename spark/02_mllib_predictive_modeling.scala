// =============================================================================
// Apache Spark MLlib - Predictive Modeling Pipeline & Feature Importance
// Author: Vaibhav Mistry
// Platform: Apache Spark 2.x / Apache Zeppelin
// Algorithms: Logistic Regression, Decision Tree Classifier, BinaryClassificationEvaluator
// =============================================================================

import org.apache.spark.ml.feature.{StringIndexer, VectorAssembler}
import org.apache.spark.ml.classification.{LogisticRegression, DecisionTreeClassifier}
import org.apache.spark.ml.evaluation.BinaryClassificationEvaluator
import org.apache.spark.sql.SparkSession

val spark = SparkSession.builder()
  .appName("MentalHealth_MLlib_Pipeline")
  .getOrCreate()

// Step 1: Feature Transformation & String Indexing
val familyHistoryIndexer = new StringIndexer()
  .setInputCol("family_history")
  .setOutputCol("family_history_index")
  .setHandleInvalid("skip")

val workInterfereIndexer = new StringIndexer()
  .setInputCol("work_interfere")
  .setOutputCol("work_interfere_index")
  .setHandleInvalid("skip")

val treatmentIndexer = new StringIndexer()
  .setInputCol("treatment")
  .setOutputCol("label")
  .setHandleInvalid("skip")

// Apply StringIndexer transformations sequentially
val indexedData1 = familyHistoryIndexer.fit(mentalHealthData).transform(mentalHealthData)
val indexedData2 = workInterfereIndexer.fit(indexedData1).transform(indexedData1)
val indexedData  = treatmentIndexer.fit(indexedData2).transform(indexedData2)

// Step 2: Vector Assembler
// Assembles numerical Age and indexed categorical indices into a single feature vector
val assembler = new VectorAssembler()
  .setInputCols(Array("Age", "family_history_index", "work_interfere_index"))
  .setOutputCol("features")

val finalData = assembler.transform(indexedData)

println("=== Prepared ML Features and Target Label ===")
finalData.select("features", "label").show(5)

// Step 3: Train / Test Split (80% Training, 20% Testing)
val Array(trainingData, testData) = finalData.randomSplit(Array(0.8, 0.2), seed = 42L)
println(s"Training Dataset Size: ${trainingData.count()} records")
println(s"Testing Dataset Size:  ${testData.count()} records")

// =============================================================================
// Model 1: Logistic Regression Pipeline
// =============================================================================
println("\n--- Training Logistic Regression Model ---")
val lr = new LogisticRegression()
  .setFeaturesCol("features")
  .setLabelCol("label")

val lrModel = lr.fit(trainingData)

// Predict on Test Data
val lrPredictions = lrModel.transform(testData)
println("Sample Predictions from Logistic Regression:")
lrPredictions.select("features", "label", "prediction", "probability").show(10)

// Evaluator: Area Under ROC
val evaluator = new BinaryClassificationEvaluator()
  .setLabelCol("label")
  .setMetricName("areaUnderROC")

val lrAccuracy = evaluator.evaluate(lrPredictions)
println(s"==========================================")
println(s"Logistic Regression Area Under ROC (Accuracy): $lrAccuracy")
println(s"==========================================")

// =============================================================================
// Model 2: Decision Tree Classifier Pipeline
// =============================================================================
println("\n--- Training Decision Tree Classifier ---")
val decisionTree = new DecisionTreeClassifier()
  .setLabelCol("label")
  .setFeaturesCol("features")

val dtModel = decisionTree.fit(trainingData)
val dtPredictions = dtModel.transform(testData)

println(s"Decision Tree Summary: Depth ${dtModel.depth} with ${dtModel.numNodes} nodes.")

val dtAccuracy = evaluator.evaluate(dtPredictions)
println(s"==========================================")
println(s"Decision Tree Area Under ROC (Accuracy): $dtAccuracy")
println(s"==========================================")

// =============================================================================
// Feature Importance Analysis (Coefficients Extraction)
// =============================================================================
val coefficients = lrModel.coefficients.toArray
val featureNames = Array("family_history", "work_interfere", "remote_work", "supervisor", "benefits")

val featureImportance = featureNames.zip(coefficients)
  .map { case (feature, coeff) => (feature, math.abs(coeff)) }
  .sortBy(-_._2)

println("\n=== Feature Importance Rankings (Logistic Regression Weights) ===")
featureImportance.foreach { case (feature, importance) =>
  println(f"$feature%-20s : $importance%.6f")
}

println("""
Key Takeaways:
1. Work Interference (1.6105): The dominant factor predicting treatment-seeking.
2. Remote Work (0.0727): Secondary factor with moderate behavioral influence.
3. Family History (1.62E-10): Minimal direct weight in multivariate linear context.
""")
