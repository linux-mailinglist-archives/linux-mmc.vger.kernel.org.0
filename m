Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3CB7AEF68
	for <lists+linux-mmc@lfdr.de>; Tue, 26 Sep 2023 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjIZPFD (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 26 Sep 2023 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjIZPEp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2023 11:04:45 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D8E73
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 08:04:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d857c8a1d50so10179533276.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2023 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695740663; x=1696345463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi8I/a7o7wwNWCt1t7ekaKgHNV+vsdHqCcY2PQYg2QI=;
        b=zkXj+jWgCXTz8EVcqT4K+5J9FTmhy1AsGvuhiNbT9vvQiDkcI3FPAbt4cZAawG8rs9
         5D+mhHmhlKrnfMafXDymPIALL4dxUoEdQuO7rE4Avjpn/o156+PJEygwEQUKPMqkGgcn
         mSOVtlhzNODEU0wMJLZzGesogWeqngupnEgAlGLaE1yKskTv34Jc32fI3IrXqy6Naw+L
         n43c9h5yeXBsXaEqmpfu/JAcm4llYv9giN6H0tgCLAiEC3OwSDqYNv26XDeSO2gEKLGN
         aOH6ufFWeXvyy85tFU+amTHC8nboW0SkHXHjAVeis2y/L35Mlc8W11ctEGKAhbvXWexy
         EQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740663; x=1696345463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi8I/a7o7wwNWCt1t7ekaKgHNV+vsdHqCcY2PQYg2QI=;
        b=Q6oisUIqDf75ar9+wyxTg02e4U/SJXBVbDOMdbComk538AZFic+owUl1Zvnh4Dqc/o
         K9jP/PY8fUPIgxMpeNZbZvcJb3I+haOkNgA1L+NOmVMLZvB0yz5LNq6QAlLwohfwtIhD
         2hKLQN0z/p6Oaep3AkL0qy6vKRBlolOZmUHHIq6FFYRS5GelHlKYX0XlgNUdz6e+OARp
         Ukh5JmBZP3RDY/i6Sj8kUEubq+cBlrgQILEfEKKEuIzvYUe/5UcdmNAtoB7XIkY1j5bD
         XDS97MEmUqYqd9lXHlj0RuW4iABQ4PyLNUYvdZT/O7p40nPTniajMozacynXOS3RoIYJ
         cjQg==
X-Gm-Message-State: AOJu0YzlJNojCNRmuKzlbfmIKYp943gF+M/KpIamjd84SK5qpoXU5P6X
        P48PGFu2BSSZMHsoZo+zybIeUffqORHuqAlZyiygxw==
X-Google-Smtp-Source: AGHT+IGQ+cDmUBy1mScBjOKjo++Q7IVdwaEUb7YBFTbK5U0lEpvDf6oS2L6LJvgIzbDQlTFsBZNTNRnN7t9lk62BZKU=
X-Received: by 2002:a5b:54b:0:b0:d84:90c5:4e1f with SMTP id
 r11-20020a5b054b000000b00d8490c54e1fmr7705526ybp.63.1695740663508; Tue, 26
 Sep 2023 08:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175249.work.593-kees@kernel.org>
In-Reply-To: <20230922175249.work.593-kees@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Sep 2023 17:03:47 +0200
Message-ID: <CAPDyKFo2CeV2Gw-MCbYvA=SRMrb+BptK3hW7f3sz2m1ChmgMAw@mail.gmail.com>
Subject: Re: [PATCH] memstick: jmb38x_ms: Annotate struct jmb38x_ms with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Tom Rix <trix@redhat.com>,
        Len Baker <len.baker@gmx.com>,
        Dan Carpenter <error27@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-mmc@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 Sept 2023 at 19:52, Kees Cook <keescook@chromium.org> wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct jmb38x_ms.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Len Baker <len.baker@gmx.com>
> Cc: Dan Carpenter <error27@gmail.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/memstick/host/jmb38x_ms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index 21cb2a786058..e77eb8b0eb12 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -66,7 +66,7 @@ struct jmb38x_ms_host {
>  struct jmb38x_ms {
>         struct pci_dev        *pdev;
>         int                   host_cnt;
> -       struct memstick_host  *hosts[];
> +       struct memstick_host  *hosts[] __counted_by(host_cnt);
>  };
>
>  #define BLOCK_COUNT_MASK       0xffff0000
> --
> 2.34.1
>
