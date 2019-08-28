import numpy as np
import os
import sys
from sklearn import datasets
from sklearn.ensemble import IsolationForest
import mlflow
import mlflow.sklearn

def generate_data():
    outliers_fraction = 0.15
    n_samples = 1000

    n_outliers = int(outliers_fraction * n_samples)
    n_inliers = n_samples - n_outliers

    # Generate inliers
    inliers = datasets.make_blobs(
        n_samples=n_inliers,
        n_features=2,
        centers=[[2, 2], [-2, -2]],
        cluster_std=[0.5, 0.5],
        random_state=0
    )[0]

    # Generate outliers
    rng = np.random.RandomState(13)
    outliers = rng.uniform(low=-6, high=6, size=(n_outliers, 2))

    return np.concatenate([inliers, outliers], axis=0)

if __name__ == '__main__':
    #print('Tracking URI: {}'.format(mlflow.tracking.get_tracking_uri()))

    with mlflow.start_run() as run:
        
        contamination = 0.15

        model = IsolationForest(n_jobs=-1, contamination=contamination, behaviour="new")
        model.fit(generate_data())

        if 'CODEBUILD_RESOLVED_SOURCE_VERSION' in os.environ:
            mlflow.set_tag('mlflow.source.git.commit', os.getenv('CODEBUILD_RESOLVED_SOURCE_VERSION'))
        mlflow.log_param("contamination", contamination)
        mlflow.sklearn.log_model(model, "models")
        print('RUN_ID::{}::'.format(run.info.run_id))