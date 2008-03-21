using nu.Model.Template;

namespace nu.Model.Project.Transformation
{
    public abstract class AbstractTransformationElement
    {
        protected const string PROJECT_KEY = "ProjectName";
        protected const string DIRECTORY_KEY = "Directory";
        protected const string DIRECTORY_SEPARATOR_KEY = "PathSeparator";

        public abstract bool Transform(IProjectManifest templateManifest, IProjectEnvironment environment, IProjectEnvironment templateEnvironment);

        protected virtual ITemplateContext BuildTemplateContext(IFileSystem fileSystem,
                ITemplateProcessor templateProcessor, IProjectEnvironment environment)
        {
            ITemplateContext context = templateProcessor.CreateTemplateContext();
            context.Items[PROJECT_KEY] = environment.ProjectName;
            context.Items[DIRECTORY_KEY] = environment.ProjectDirectory;
            context.Items[DIRECTORY_SEPARATOR_KEY] = fileSystem.DirectorySeparatorChar;
            return context;
        }
    }
}