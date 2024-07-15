from modeltranslation.translator import register, TranslationOptions

from blog.models import Post


@register(Post)
class PostTranslationOptions(TranslationOptions):
    fields = ('title', 'body')
