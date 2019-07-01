Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D74D19050
	for <lists+linux-mmc@lfdr.de>; Thu,  9 May 2019 20:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEISmk (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 9 May 2019 14:42:40 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:35407 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISmk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 May 2019 14:42:40 -0400
Received: by mail-it1-f193.google.com with SMTP id u186so5068273ith.0
        for <linux-mmc@vger.kernel.org>; Thu, 09 May 2019 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RAPPdEdzAC7Nt0I8+scXV0pUykQdkkkD3cPHgHiKjU8=;
        b=EA/ichp6rKwQmA41fESwb4j4uaWeWuD52YwU65vVfIMfrBbr4qm22odgAbc3y+KOs4
         uYtoXshTC+9v7P5K2ki7wA/nXY6y+10wXkP2bjJcjn7xTcvFF2udokT0RUM3wfsxjAje
         5+RFMzEtEJfNe7ooxe3LuywCyZ2OPUGCwJhnCKidxxonlz3UP/qDZIjlEQpRNrqJVaCy
         6CrA6yLQyV1A6SmbHlFMNs3jlVcWRPZ03NZH91sP+9Vnf8jydOqYanUq9ynmqs0WPwBI
         RWSvlOla6ubGeBj71dCKdwaSkM7exDz2LC3xX8x1eoG+yGfpAOpPoUuFPk+l60eH9cbV
         UNcQ==
X-Gm-Message-State: APjAAAXC8ukjSQj+WGn29TZhTtt0hGLYr0w7r6cEMa9afjbv9Afy4Q3h
        x8zUVHxhZxQMaO6253WsydLs6Q==
X-Google-Smtp-Source: APXvYqz/8tymkjQmLnwRihvpLkgn17Ri7VMfntsvcRf0uxgb8XJaXi9AYQEnf2j9n/EgX0JRGNMKcA==
X-Received: by 2002:a24:17ce:: with SMTP id 197mr4164215ith.21.1557427359216;
        Thu, 09 May 2019 11:42:39 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id h16sm1021805ioh.35.2019.05.09.11.42.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 11:42:38 -0700 (PDT)
Date:   Thu, 9 May 2019 12:42:34 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Message-ID: <20190509184234.GA197434@google.com>
References: <20190508185833.187068-1-rrangel@chromium.org>
 <20190509060456.GA17096@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509060456.GA17096@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, May 08, 2019 at 11:04:56PM -0700, Christoph Hellwig wrote:
> On Wed, May 08, 2019 at 12:58:32PM -0600, Raul E Rangel wrote:
> > It is possible for queuedata to be cleared in mmc_cleanup_queue before
> > the request has been started.
> 
> Errm.  I think we need to fix that problem instead of working around it.
So mmc_request_fn already has a null check, it was just missing on
mmc_init_request.

I could move `blk_cleanup_queue(q)` above `q->queuedata = NULL` and the
lock. So that would mean cherry-picking
https://lore.kernel.org/patchwork/patch/856512/ and then a patch with
moving blk_cleanup_queue.

Should I do that instead?

Thanks,
Raul
