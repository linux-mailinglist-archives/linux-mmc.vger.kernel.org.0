Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A056B117
	for <lists+linux-mmc@lfdr.de>; Tue, 16 Jul 2019 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfGPV2w (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 16 Jul 2019 17:28:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34160 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPV2w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2019 17:28:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id p17so21463691ljg.1
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2019 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKEiPzsQ1IwIHBVeprAXWKSCp1nw89gJee9IM3qitFI=;
        b=fEB4BCJeTk7jJycD+ms6MiLosDpFsHdD9tsdL+ISijJmwow6mU9R7Njkz6T99Zmsnq
         4tRYSzKlXENnwJ3Jcw5q8DYRkvAUlvBS0qH6Qg+li5/Da5ztxW9dfv8vNOIzcaOU6eUF
         3TxNrMaeIf22zhrYHNocPO+A/NyBC9IuQ+GDWtbTg03bCQ/DkmcecYmfVDja/yCKjs5E
         61M5owjCt/6gs9wtGMFLKguZqCrMoLseG/skL7H0936nHqdNvft6pUkfQ0oufJTwP8oh
         MHTGYuVPpejFbWohFJarw+4qL0RsD70CCXQB6Qfx5RMEybueYanNXibRp8XdTg8vR2Ag
         ACtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKEiPzsQ1IwIHBVeprAXWKSCp1nw89gJee9IM3qitFI=;
        b=q/zxWJ+Brsf9hrSD9Opu5Qr6nO3MxSuBOBdMKBdqiLhU0VbNkQrYfn4cYSHGSQBd+q
         et8b27fw0WxGyzSAljJ8Ol28N6ycIvcQQnaX9cBRpc8LDEfjagFGYw8yn3/o1uui1xgQ
         Ywg00zqOIqEevp0bpWBQrHbp/hcvPE0bkzFKGkYOtknWqJEsIr22vofM4SDkna58oStX
         gcsQIYAK40zcySvlfjwo0szavuZGN3IOmqc64djinRhA8t7Yb/r7dHilmJMXbbM5Bd3x
         hKd/xN7t7q8IsUOghk14aCvnhXlvOKzyIk16lC4iiVcwhouedkgYby7SlymtWwR6kQcs
         WUkQ==
X-Gm-Message-State: APjAAAWCzJrFiOFy1ciRNtA9xhLTPg7QufiWUIdu2v1mCx7PZraRIGDw
        +g7f5KpET2b1e1Ual7Hl4ye80aPXcEiFg+qeCocTO5jr
X-Google-Smtp-Source: APXvYqzgTIOnJCkvCC3P9i2+8vNK2UHYNlfh3JvsbqaLMTIa8mO2sMaVDABM/viRyeoq6+cRWiMYsteg33gEBYhcLvI=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr17983980ljg.62.1563312529977;
 Tue, 16 Jul 2019 14:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164230.27348-1-ulf.hansson@linaro.org>
In-Reply-To: <20190715164230.27348-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Jul 2019 23:28:38 +0200
Message-ID: <CACRpkdY29h9yMTOXALLkajOSLQzDw1kU5LUDE1xE+auhO239DA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: mmci: Clarify comments in the code about busy detection
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Nicolas Graux <jean-nicolas.graux@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jul 15, 2019 at 6:42 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The code dealing with busy detection is somewhat complicated. In a way to
> make it a bit clearer, let's try to clarify the comments in the code about
> it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Uh oh there seems to have been some refactoring of the code that
it was trying to document. Stale docs.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
