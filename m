Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEBC40FD1D
	for <lists+linux-mmc@lfdr.de>; Fri, 17 Sep 2021 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbhIQPtz (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 17 Sep 2021 11:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbhIQPtx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 11:49:53 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4179C061768
        for <linux-mmc@vger.kernel.org>; Fri, 17 Sep 2021 08:48:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f129so10033393pgc.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Sep 2021 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oU5/PdBksbt91dmMZ2AVGJIFzdhPLZCXzFzx+KRfDqk=;
        b=KDzGJ0b9khD+pih/CbX22IId0YBoC/kJyqkzfoF/YleeZhZclne1J/L8CYza9hth1j
         k0eN4rSOAq5jLCYYiXyLB+BiFSMlTE18J4j23xLqQ5cOJZDMocN7et1mYg4Ylouh4adS
         7MMd1eKp8SzWcXGjhEgr5gwm/XDc/WeglPkC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oU5/PdBksbt91dmMZ2AVGJIFzdhPLZCXzFzx+KRfDqk=;
        b=QhSxYSipsVQ9cXFe1wy05GGJap1lQz5bVS3zdNUqvqrL1l9OXLqSeouHvzhhieIzxc
         V+juD17Vn0mJcNCKb9prdspsGryDbPSS85Zodw0+JlBVNr9IyHSBZcnLzEDUeEt1ylkP
         SljeDOAsuVN2BkSRpXFG2TGmUAUvm7SFq3jcHZ9ZCQrKduSuxHdwwneJQIPtxgGMQZ1g
         7S3D+2Pl0tzfLXu0NpTwgpHFpql7gdSsVUvu7+mGQmjBD02xKzT1VCDQY5Jp/WBxFuqy
         jruYuetIaN2TUnzRFqrcSBEFxSO7J5QxS4tqtf7Rb8eWPfhaAEu4qyJuJ9fW7M5H8yjL
         nSwA==
X-Gm-Message-State: AOAM530dCkmUC8jRR/w1++b3tuMlWdwYIHviuisOi55GVcII6HbmS0Xq
        LnLWDZvQqk5AIGB6ek5wBoFE/w==
X-Google-Smtp-Source: ABdhPJywPsJt5eForru+BeWv06Lmr+gWdQ+HZR8iE1hgtztL0deStFU6zzGj865eVc8KXipuQb3DZw==
X-Received: by 2002:a63:da54:: with SMTP id l20mr10404254pgj.341.1631893710953;
        Fri, 17 Sep 2021 08:48:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t68sm6925395pgc.59.2021.09.17.08.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 08:48:30 -0700 (PDT)
Date:   Fri, 17 Sep 2021 08:48:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        rafael@kernel.org, jic23@kernel.org, lars@metafoo.de,
        ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v1 1/6] gcc-plugins/structleak: add makefile var for
 disabling structleak
Message-ID: <202109170808.629688A460@keescook>
References: <20210917061104.2680133-1-brendanhiggins@google.com>
 <20210917061104.2680133-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917061104.2680133-2-brendanhiggins@google.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 16, 2021 at 11:10:59PM -0700, Brendan Higgins wrote:
> KUnit and structleak don't play nice, so add a makefile variable for
> enabling structleak when it complains.
> 
> Co-developed-by: Kees Cook <keescook@chromium.org>

For a C-d-b, also include a S-o-b:

Signed-off-by: Kees Cook <keescook@chromium.org>

But otherwise, yes, this is good. :)

-Kees

> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  scripts/Makefile.gcc-plugins | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 952e46876329a..4aad284800355 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -19,6 +19,10 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)		\
>  		+= -fplugin-arg-structleak_plugin-byref
>  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	\
>  		+= -fplugin-arg-structleak_plugin-byref-all
> +ifdef CONFIG_GCC_PLUGIN_STRUCTLEAK
> +    DISABLE_STRUCTLEAK_PLUGIN += -fplugin-arg-structleak_plugin-disable
> +endif
> +export DISABLE_STRUCTLEAK_PLUGIN
>  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
>  		+= -DSTRUCTLEAK_PLUGIN
>  
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

-- 
Kees Cook
